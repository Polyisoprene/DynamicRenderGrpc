# -*- encoding: utf-8 -*-
"""
@File    :   TypeMajor.py
@Time    :   2022/06/18 21:35:17
@Author  :   DMC
"""
import asyncio
import re
from abc import ABCMeta, abstractmethod
from concurrent.futures import ThreadPoolExecutor
from os import path, getcwd
from typing import Union, List

import cv2 as cv
import numpy
import numpy as np
from PIL import Image, ImageFont, ImageDraw
from fontTools.ttLib import TTFont
from numpy import ndarray

from bilibili.app.dynamic.v2.dynamic_pb2 import ModuleDynamic, MdlDynDrawItem
from .Config import ConfigReader
from .Dynamic import logger
from .Tools import PicGetter, TextCalculate


# mdl_dyn_archive = 0;           // 稿件
# mdl_dyn_pgc = 1;               // pgc
# mdl_dyn_cour_season = 2;       // 付费课程-系列
# mdl_dyn_cour_batch = 3;        // 付费课程-批次
# mdl_dyn_forward = 4;           // 转发卡
# mdl_dyn_draw = 5;              // 图文
# mdl_dyn_article = 6;           // 专栏
# mdl_dyn_music = 7;             // 音频
# mdl_dyn_common = 8;            // 通用卡方
# mdl_dyn_live = 9;              // 直播卡
# mdl_dyn_medialist = 10;        // 播单
# mdl_dyn_applet = 11;           // 小程序卡
# mdl_dyn_subscription = 12;     // 订阅卡
# mdl_dyn_live_rcmd = 13;        // 直播推荐卡
# mdl_dyn_ugc_season = 14;       // UGC合集
# mdl_dyn_subscription_new = 15; // 订阅卡

class DrawPic(ConfigReader):
    """
    绘制文本及emoji
    """

    def __init__(self):
        super().__init__()
        self.relative_path = getcwd()

        self.font_key = \
            TTFont(path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name),
                   fontNumber=0)[
                'cmap'].tables[0].ttFont.getBestCmap().keys()
        self.img = None
        self.main_font = None
        self.standby_font = None

    async def run(self, font_size=None, img=None, img_info: list = None):
        if font_size:
            self.main_font = ImageFont.truetype(
                path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name), font_size)
            self.standby_font = ImageFont.truetype(
                path.join(self.relative_path, "Static", "Font", self.config_content.font.standby_font_name), font_size)
        self.img = img
        self.draw = ImageDraw.Draw(self.img)
        await asyncio.gather(*[self.draw_img(i) for i in img_info])
        return self.img

    async def draw_img(self, img_dict: dict):
        if img_dict["info_type"] == "text":
            text = img_dict["content"]
            if len(text) == 1 and (ord(text) not in self.font_key):
                self.draw.text(img_dict["position"], text, fill=img_dict["font_color"],
                               font=self.standby_font)
            else:
                self.draw.text(img_dict["position"], text, fill=img_dict["font_color"],
                               font=self.main_font)
        else:
            img = img_dict["content"]
            self.img.paste(img, img_dict["position"], img)


class AbstractMajorRender(metaclass=ABCMeta):
    @abstractmethod
    async def major_render(self, major_item: ModuleDynamic) -> Union[None, ndarray]:
        pass


class AbstractMajor(metaclass=ABCMeta):
    @abstractmethod
    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        pass


class MAJOR_TYPE_PGC(ConfigReader, AbstractMajor, PicGetter):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 695), self.config_content.color.forward_color)
            else:
                self.background = Image.new("RGBA", (1080, 695), self.config_content.color.backgroud_color)
            title = major_item.dyn_pgc.title
            duration = major_item.dyn_pgc.cover_left_text_1
            cover_uri = major_item.dyn_pgc.cover
            badge = major_item.dyn_pgc.badge_category[1].text
            await self.make_main_card(cover_uri, title, duration, badge)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    async def make_main_card(self, cover_uri, title, duration, badge):

        play_icon = Image.open(path.join(getcwd(), "Static", "Picture", "tv.png")).resize((130, 130))
        cover = PicGetter().pic_getter(f"{cover_uri}@505w_285h_1c.webp", mode="PIL")
        cover = cover.resize((1010, 570))
        duration_pic = self.make_duration_info(duration)
        badge_img = self.make_badge(badge)
        images = await asyncio.gather(duration_pic, badge_img)
        title_size = self.config_content.size.main_size
        title_position = await TextCalculate().calculate(title_size,
                                                         self.config_content.color.text_color, 1020, 600, 35, 605,
                                                         title)
        title_position.append({"info_type": "img", "content": cover, "position": (35, 25)})
        title_position.append({"info_type": "img", "content": images[0], "position": (80, 525)})
        title_position.append({"info_type": "img", "content": images[1], "position": (925, 40)})
        img = await DrawPic().run(title_size, self.background, title_position)
        img.paste(play_icon, (905, 455), play_icon)
        self.background = img

    async def make_duration_info(self, duration: str):
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        duration_size = font.getsize(duration)
        bk_pic_size = (duration_size[0] + 20, duration_size[1] + 20)
        bk_pic = Image.new("RGBA", bk_pic_size, (0, 0, 0, 90))
        draw = ImageDraw.Draw(bk_pic)
        draw.text((10, 5), duration, fill=(255, 255, 255, 255), font=font)
        return bk_pic

    async def make_badge(self, badge):
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        badge_size = font.getsize(badge)
        bk_pic_size = (badge_size[0] + 20, badge_size[1] + 20)
        bk_pic = Image.new("RGBA", bk_pic_size, "#fb7299")
        draw = ImageDraw.Draw(bk_pic)
        draw.text((10, 5), badge, fill=(255, 255, 255, 255), font=font)
        return bk_pic


class MAJOR_TYPE_ARCHIVE(ConfigReader, AbstractMajor, PicGetter):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        """
        渲染Archive类Major的入口函数
        :param major_item:
        :param forward:
        :return:
        """
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 695), self.config_content.color.forward_color)
            else:
                self.background = Image.new("RGBA", (1080, 695), self.config_content.color.backgroud_color)
            cover_uri = major_item.dyn_archive.cover
            title = major_item.dyn_archive.title
            duration = major_item.dyn_archive.cover_left_text_1
            await self.make_main_card(cover_uri, title, duration)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return

    async def make_main_card(self, cover_uri, title, duration):

        play_icon = Image.open(path.join(getcwd(), "Static", "Picture", "tv.png")).resize((130, 130))
        cover = PicGetter().pic_getter(f"{cover_uri}@505w_285h_1c.webp", mode="PIL")
        cover = cover.resize((1010, 570))
        duration_pic = await self.make_duration_info(duration)

        title_size = self.config_content.size.main_size
        title_position = await TextCalculate().calculate(title_size,
                                                         self.config_content.color.text_color, 1020, 600, 35, 605,
                                                         title)
        title_position.append({"info_type": "img", "content": cover, "position": (35, 25)})
        title_position.append({"info_type": "img", "content": duration_pic, "position": (80, 525)})
        img = await DrawPic().run(title_size, self.background, title_position)
        img.paste(play_icon, (905, 455), play_icon)
        self.background = img

    async def make_duration_info(self, duration: str):
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        duration_size = font.getsize(duration)
        bk_pic_size = (duration_size[0] + 20, duration_size[1] + 20)
        bk_pic = Image.new("RGBA", bk_pic_size, (0, 0, 0, 90))
        draw = ImageDraw.Draw(bk_pic)
        draw.text((10, 5), duration, fill=(255, 255, 255, 255), font=font)
        return bk_pic


class MAJOR_TYPE_MUSIC(ConfigReader, AbstractMajor, PicGetter):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        cover = major_item.dyn_music.cover
        cover = PicGetter().pic_getter(f"{cover}@190w_190h_1c.webp", "PIL")
        position_info = await self.get_position(title=major_item.dyn_music.title, label=major_item.dyn_music.label1)
        if forward:
            self.background = Image.new("RGBA", (1080, 210), self.config_content.color.forward_color)
        else:
            self.background = Image.new("RGBA", (1080, 210), self.config_content.color.backgroud_color)
        img = ImageDraw.ImageDraw(self.background)
        img.rectangle(((35, 10), (1045, 200)), fill=self.config_content.color.backgroud_color, outline='#e5e9ef',
                      width=2)
        draw = DrawPic()
        title_task = draw.run(self.config_content.size.main_size, self.background, position_info[0])
        label_task = draw.run(self.config_content.size.sub_title_size, self.background, position_info[1])
        cover_task = draw.run(img=self.background,
                              img_info=[{"info_type": "img", "content": cover, "position": (35, 10)}])
        await asyncio.gather(title_task, label_task, cover_task)

        return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)

    async def get_position(self, title, label):
        title_size = self.config_content.size.main_size
        label_size = self.config_content.size.sub_title_size
        title_position_task = TextCalculate().calculate(title_size, self.config_content.color.text_color, 1020,
                                                        65, 280, 55, title)
        label_position_task = TextCalculate().calculate(label_size, self.config_content.color.sub_font_color, 1020,
                                                        115, 280, 115, label)
        return await asyncio.gather(title_position_task, label_position_task)


class MAJOR_TYPE_DRAW(ConfigReader, AbstractMajor, PicGetter):
    def __init__(self) -> None:
        super().__init__()

    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        """渲染Draw类Major的入口函数

        :param major_item: major主体
        :type major_item: Major
        :param forward: 判断是否是转发动态的Major
        :type forward: bool
        :return: 渲染好的Major图片
        :rtype: ndarray
        """
        try:
            pic_items = major_item.dyn_draw.items
            pic_num = len(pic_items)
            if pic_num == 1:
                imgs = await self.single_pic_url(pic_items)
            elif pic_num in {2, 4}:
                imgs = await self.double_pic_url(pic_items)
            else:
                imgs = await self.triplex_pic_url(pic_items)

            self.backgroud = cv.cvtColor(
                np.asarray(Image.new("RGBA", imgs[0]["backgroud_size"], self.config_content.color.forward_color)),
                cv.COLOR_RGBA2BGRA) if forward else cv.cvtColor(
                np.asarray(Image.new("RGBA", imgs[0]["backgroud_size"], self.config_content.color.backgroud_color)),
                cv.COLOR_RGBA2BGRA)
            for i in imgs:
                await self.assemble(i)

            return self.backgroud
        except Exception as e:
            logger.exception("What?!")
            return

    async def single_pic_url(self, pic_items: List[MdlDynDrawItem]) -> list:
        """对单张图片信息进行处理

        :param pic_items: 图片信息
        :type pic_items: List[PicItem]
        :return: 处理好的图片列表
        :rtype: list
        """
        img_item = pic_items[0]
        src = img_item.src
        img_height = img_item.height
        img_width = img_item.width
        if img_height / img_width > 4:
            img_url = f"{src}@{img_width}w_{img_width}h_!header.webp"
        else:
            img_url = src
        img_ndarray = self.pic_getter(img_url, mode="ndarry")
        img_shape = img_ndarray.shape
        img = cv.resize(img_ndarray, (1008, int(img_shape[0] * 1008 / img_shape[1])), interpolation=cv.INTER_NEAREST)
        bk_size = img.shape
        return [{"img": img, "position": (36, bk_size[1] + 36, 10, bk_size[0] + 10),
                 "backgroud_size": (1080, bk_size[0] + 20)}]

    async def double_pic_url(self, pic_items: List[MdlDynDrawItem]) -> list:
        """对两张、四张图片进行处理

        :param pic_items: 图片信息列表
        :type pic_items: List[PicItem]
        :return: 处理好的图片信息列表
        :rtype: list
        """
        url_list = []
        for item in pic_items:
            src = item.src
            img_height = item.height
            img_width = item.width
            if img_height / img_width > 3:
                url_list.append(f"{src}@520w_520h_!header.webp")
            else:
                url_list.append(f"{src}@520w_520h_1e_1c.webp")
        with ThreadPoolExecutor(max_workers=2) as pool:
            results = pool.map(self.pic_getter, url_list)
        num = len(pic_items) / 2
        back_size = int(num * 520 + 20 * num)
        pic_list = []
        x, y = 15, 10
        for i in results:
            i = cv.resize(i, (520, 520), interpolation=cv.INTER_NEAREST)
            pic_list.append({"img": i, "position": (x, x + 520, y, y + 520), "backgroud_size": (1080, back_size)})
            x += 530
            if x > 1000:
                x = 15
                y += 530
        return pic_list

    async def triplex_pic_url(self, pic_items: List[MdlDynDrawItem]) -> list:
        """对三张、五张、六张图片进行处理

        :param pic_items: 图片列表
        :type pic_items: List[PicItem]
        :return: 图片的信息列表
        :rtype: list
        """
        url_list = []
        for item in pic_items:
            src = item.src
            img_height = item.height
            img_width = item.width
            if img_height / img_width > 3:
                url_list.append(f"{src}@346w_346h_!header.webp")
            else:
                url_list.append(f"{src}@346w_346h_1c.webp")
        with ThreadPoolExecutor(max_workers=3) as pool:
            results = pool.map(self.pic_getter, url_list)
        num = round(len(pic_items) / 3)
        back_size = int(num * 346 + 20 * num)
        x, y = 11, 10
        pic_list = []
        for i in results:
            i = cv.resize(i, (346, 346), interpolation=cv.INTER_NEAREST)
            pic_list.append({"img": i, "position": (x, x + 346, y, y + 346), "backgroud_size": (1080, back_size)})
            x += 356
            if x > 1000:
                x = 11
                y += 356
        return pic_list

    async def assemble(self, item: dict) -> None:
        """组装图片

        :param item: 图片列表
        :type item: dict
        """
        position = item["position"]
        self.backgroud[position[2]:position[3], position[0]:position[1], :] = item["img"][:, :, :]


class MAJOR_TYPE_COMMON(ConfigReader, AbstractMajor):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, major_item: ModuleDynamic, forward: bool = False) -> Union[ndarray, None]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 285), self.config_content.color.forward_color)
            else:
                self.background = Image.new("RGBA", (1080, 285), self.config_content.color.backgroud_color)
            img = ImageDraw.ImageDraw(self.background)
            img.rectangle(((35, 20), (1045, 265)), fill=self.config_content.color.backgroud_color, outline='#e5e9ef',
                          width=2)
            if major_item.dyn_common.bizType == 201:
                return await self.common_comic(major_item)
            else:
                return await self.common_general(major_item)
        except Exception as e:
            logger.exception("What?!")
            logger.error("渲染Major_Common失败")
            return

    async def common_comic(self, major_item: ModuleDynamic):
        """
        漫画类型的common
        :param major_item:
        :return:
        """
        url_without_webp = re.compile(r"@\d+w_\d+h.webp").sub('', major_item.dyn_common.cover)
        url = f"{url_without_webp}@180w_245h_1c.webp"
        title = major_item.dyn_common.title
        label = major_item.dyn_common.label
        desc = major_item.dyn_common.desc
        title_size = self.config_content.size.main_size
        sub_title_size = self.config_content.size.sub_title_size
        cover = PicGetter().pic_getter(url, "PIL").resize((180, 245))
        cover_position = [{"info_type": "img", "content": cover, "position": (35, 20)}]
        title_position = TextCalculate().calculate(title_size,
                                                   self.config_content.color.text_color, 1000, 40, 245, 40,
                                                   title)
        label_position = TextCalculate().calculate(sub_title_size,
                                                   self.config_content.color.sub_font_color, 1000, 180, 245, 180,
                                                   label)

        desc_position = TextCalculate().calculate(sub_title_size,
                                                  self.config_content.color.sub_font_color, 1000, 115, 245, 115,
                                                  desc)

        result = await asyncio.gather(title_position, desc_position, label_position)
        draw = DrawPic()
        task_1 = draw.run(title_size, self.background, result[0])
        task_2 = draw.run(sub_title_size, self.background, result[1])
        if major_item.dyn_common.badge:
            cover_position.extend(await self.make_badge(major_item.dyn_common.badge))
        task_3 = draw.run(sub_title_size, self.background, cover_position)
        task_4 = draw.run(sub_title_size, self.background, result[2])
        await asyncio.gather(task_1, task_2, task_3, task_4)

        return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)

    async def common_general(self, major_item: ModuleDynamic):
        """
        :param major_item:
        :return:
        """
        url_without_webp = re.compile(r"@\d+w_\d+h.webp").sub('', major_item.dyn_common.cover)
        url = f"{url_without_webp}@245w_245h_1c.webp"
        title = major_item.dyn_common.title
        desc = major_item.dyn_common.desc
        title_size = self.config_content.size.main_size
        sub_title_size = self.config_content.size.sub_title_size
        cover = PicGetter().pic_getter(url, "PIL").resize((245, 245))
        cover_position = [{"info_type": "img", "content": cover, "position": (35, 20)}]
        if major_item.dyn_common.badge:
            cover_position.extend(await self.make_badge(major_item.dyn_common.badge))
        title_position = TextCalculate().calculate(title_size,
                                                   self.config_content.color.text_color, 900, 85, 310, 85,
                                                   title)
        desc_position = TextCalculate().calculate(sub_title_size,
                                                  self.config_content.color.sub_font_color, 1000, 170, 310, 170,
                                                  desc)
        result = await asyncio.gather(title_position, desc_position)
        draw = DrawPic()
        task_1 = draw.run(title_size, self.background, result[0])
        task_2 = draw.run(sub_title_size, self.background, result[1])
        task_3 = draw.run(sub_title_size, self.background, cover_position)
        await asyncio.gather(task_1, task_2, task_3)
        return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)

    async def make_badge(self, badge):
        """
        制作badge
        :param badge:
        :return:
        """
        text = badge[0].text
        text_color = badge[0].text_color
        bg_color = badge[0].bg_color
        badge_img = Image.new("RGBA", (100, 50), bg_color)
        text_info = []
        badge_img = await DrawPic().run(self.config_content.size.sub_title_size, badge_img, text_info)
        return [{"info_type": "img", "content": badge_img, "position": (915, 35)},
                {"info_type": "text", "content": text, "position": (930, 35), "font_color": text_color}]


class MajorRender(AbstractMajorRender):
    def __init__(self) -> None:
        pass

    async def major_render(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        try:
            major_map = {0: "MAJOR_TYPE_ARCHIVE", 1: "MAJOR_TYPE_PGC", 5: "MAJOR_TYPE_DRAW", 7: "MAJOR_TYPE_MUSIC",
                         8: "MAJOR_TYPE_COMMON"}
            major_name = major_map[major_item.type]
            return await eval(f"{major_name}()").run(major_item, forward)
        except KeyError:
            logger.exception("What?!")
            logger.error("未知类型major")
            return None
        except Exception as e:
            logger.exception("What?!")
            logger.error("Major渲染失败")
            return None
