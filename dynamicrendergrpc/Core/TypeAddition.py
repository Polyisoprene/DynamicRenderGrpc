# -*- encoding: utf-8 -*-
"""
@File    :   TypeAddition.py
@Time    :   2022/06/18 21:34:41
@Author  :   DMC
"""
import asyncio
from abc import ABCMeta, abstractmethod
from concurrent.futures import ThreadPoolExecutor
from os import path, getcwd
from typing import Union

import cv2 as cv
import numpy
from PIL import Image, ImageDraw, ImageFont
from numpy import ndarray

from .Config import ConfigReader
from .Dynamic import logger
from .Tools import TextCalculate, DrawPic, PicGetter


class AbstractAddition(metaclass=ABCMeta):
    @abstractmethod
    async def addition_render(self, additional_item, forward=False) -> Union[ndarray, None]:
        pass


class AbstractAdditionalRender(metaclass=ABCMeta):
    @abstractmethod
    async def run(self, additional_item, forward: bool) -> Union[ndarray, None]:
        pass


class ADDITIONAL_RESERVE(ConfigReader, AbstractAdditionalRender):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, additional_item, forward: bool) -> Union[ndarray, None]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 225), self.config_content.color.forward_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 205)), fill=self.config_content.color.backgroud_color,
                              outline='#e5e9ef',
                              width=2)
            else:
                self.background = Image.new("RGBA", (1080, 225), self.config_content.color.backgroud_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 205)), fill=self.config_content.color.forward_color,
                              outline='#e5e9ef',
                              width=2)
            title = additional_item.up.title
            label = f"{additional_item.up.desc_text_1.text} · {additional_item.up.desc_text_2}"
            text_position_info = await self.get_text_position_info(title, label)
            btn_info = await self.get_btn_info(additional_item.up.button)
            draw = DrawPic()
            title_task = draw.run(self.config_content.size.main_size, self.background, text_position_info[0])
            label_task = draw.run(self.config_content.size.sub_size, self.background, text_position_info[1])
            btn_task = draw.run(self.config_content.size.sub_size, self.background, btn_info)
            await asyncio.gather(title_task, label_task, btn_task)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    async def get_text_position_info(self, title: str, label: str):
        title_size = self.config_content.size.main_size
        label_size = self.config_content.size.sub_size
        title_task = TextCalculate().calculate(title_size, self.config_content.color.text_color, 810, 70, 75, 70, title)
        label_task = TextCalculate().calculate(label_size, self.config_content.color.sub_font_color, 810, 140, 75, 140,
                                               label)
        return await asyncio.gather(title_task, label_task)

    async def get_btn_info(self, button):
        if button.check.text and button.status:
            text = button.check.text if button.status != 1 else button.uncheck.text
        else:
            text = button.jump_style.text
        btn_img = Image.new("RGBA", (170, 75), "#00a1d6")
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        text_size = font.getsize(text)
        x = int((170 - text_size[0]) / 2)
        y = int((75 - text_size[1]) / 2)
        return [{"info_type": "img", "content": btn_img, "position": (850, 75)}, {"info_type": "text", "content": text,
                                                                                  "position": (x + 850, y + 75),
                                                                                  "font_color": "#ffffff"}]


class ADDITIONAL_GOODS(ConfigReader, AbstractAdditionalRender):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, additional_item, forward: bool) -> Union[ndarray, None]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 280), self.config_content.color.forward_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 260)), fill=self.config_content.color.backgroud_color,
                              outline='#e5e9ef',
                              width=2)
            else:
                self.background = Image.new("RGBA", (1080, 280), self.config_content.color.backgroud_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 260)), fill=self.config_content.color.forward_color,
                              outline='#e5e9ef',
                              width=2)
            if len(additional_item.goods.goods_items) == 1:
                await self.single_cover(additional_item)
            else:
                await self.multi_cover(additional_item)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    async def single_cover(self, additional_item):
        text_info_task = self.get_text_position(additional_item.goods.goods_items[0].title,
                                                additional_item.goods.goods_items[0].price)

        cover_info_task = self.get_cover(additional_item.goods.goods_items[0].cover)

        result = await asyncio.gather(text_info_task, cover_info_task)
        draw = DrawPic()
        title_task = draw.run(self.config_content.size.main_size, self.background, img_info=result[0][0])
        price_task = draw.run(self.config_content.size.main_size, self.background, img_info=result[0][1])
        cover_task = draw.run(self.config_content.size.sub_size, self.background, img_info=result[1])
        await asyncio.gather(title_task, price_task, cover_task)

    async def get_text_position(self, title, price):
        title_size = self.config_content.size.main_size
        price_size = self.config_content.size.sub_title_size
        title_task = TextCalculate().calculate(title_size, self.config_content.color.text_color, 1000, 90, 295, 90,
                                               title)
        label_task = TextCalculate().calculate(price_size, self.config_content.color.extra_color, 1000, 160, 295, 160,
                                               f"{price}起")
        return await asyncio.gather(title_task, label_task)

    async def get_cover(self, cover):
        bili_pink = self.config_content.color.bili_pink
        cover_url = f"{cover}@190w_190h_1c.webp"
        cover = PicGetter().pic_getter(cover_url, "PIL")
        return [{"info_type": "img", "content": cover, "position": (60, 45)}, {"info_type": "text", "content": "去看看 >",
                                                                               "position": (900, 195),
                                                                               "font_color": bili_pink}]

    async def multi_cover(self, additional_item):
        cover_list = [f"{i.cover}@190w_190h_1c.webp" for i in additional_item.goods.goods_items]
        mod = ["PIL" for _ in cover_list]
        pic_getter = PicGetter()
        with ThreadPoolExecutor(max_workers=5) as pool:
            result = pool.map(pic_getter.pic_getter, cover_list, mod)
        img_list = []
        for i, img in enumerate(result):
            x = 45 + i * 200
            if x > 1000:
                break
            img_list.append({"info_type": "img", "content": img, "position": (x, 45)})
        await DrawPic().run(img=self.background, img_info=img_list)


class ADDITIONAL_COMMON(ConfigReader, AbstractAdditionalRender):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, additional_item, forward: bool) -> Union[ndarray, None]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 285), self.config_content.color.forward_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 265)), fill=self.config_content.color.backgroud_color,
                              outline='#e5e9ef',
                              width=2)
            else:
                self.background = Image.new("RGBA", (1080, 285), self.config_content.color.backgroud_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 265)), fill=self.config_content.color.forward_color,
                              outline='#e5e9ef',
                              width=2)
            if additional_item.common.desc_text_2:
                await self.common_with_desc_text_2(additional_item)
            else:
                await self.common_without_desc_text_2(additional_item)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    async def common_without_desc_text_2(self, additional_item):
        img_url = f"{additional_item.common.image_url}@145w_195h_1c.webp"
        get_text_position_task = self.get_text_position(additional_item.common.title,
                                                        additional_item.common.desc_text_1)
        get_cover_task = self.get_cover(img_url)

        make_btn_task = self.make_btn(additional_item.common.button)

        result = await asyncio.gather(get_text_position_task, get_cover_task, make_btn_task)
        draw = DrawPic()
        title_size = self.config_content.size.main_size
        desc_size = self.config_content.size.sub_size
        title_task = draw.run(title_size, self.background, result[0][0])
        cover_task = draw.run(img=self.background, img_info=result[1])
        desc_task1 = draw.run(desc_size, self.background, result[0][1])
        btn_task = draw.run(desc_size, self.background, result[2])
        await asyncio.gather(title_task, desc_task1, cover_task, btn_task)

    async def common_with_desc_text_2(self, additional_item):
        img_url = f"{additional_item.common.image_url}@190w_190h_1c.webp"
        get_text_position_task = self.get_text_position(additional_item.common.title,
                                                        additional_item.common.desc_text_1,
                                                        additional_item.common.desc_text_2)
        get_cover_task = self.get_cover(img_url)

        make_btn_task = self.make_btn(additional_item.common.button)

        result = await asyncio.gather(get_text_position_task, get_cover_task, make_btn_task)
        draw = DrawPic()
        title_size = self.config_content.size.main_size
        desc_size = self.config_content.size.sub_size
        title_task = draw.run(title_size, self.background, result[0][0])
        cover_task = draw.run(img=self.background, img_info=result[1])
        desc_task1 = draw.run(desc_size, self.background, result[0][1])
        desc_task2 = draw.run(desc_size, self.background, result[0][2])
        btn_task = draw.run(desc_size, self.background, result[2])
        await asyncio.gather(title_task, desc_task1, desc_task2, cover_task, btn_task)

    async def get_text_position(self, title, desc_text1, desc_text2=None):
        title_size = self.config_content.size.main_size
        desc_size = self.config_content.size.sub_size
        counter = TextCalculate()
        if desc_text2:
            title_task = counter.calculate(title_size, self.config_content.color.text_color, 815, 70, 280, 70, title)
            desc_text1_task = counter.calculate(desc_size, self.config_content.color.sub_font_color, 815, 135, 280, 135,
                                                desc_text1)
            desc_text_2_task = counter.calculate(desc_size, self.config_content.color.sub_font_color, 815, 195, 280,
                                                 195, desc_text2)
            return await asyncio.gather(title_task, desc_text1_task, desc_text_2_task)
        else:
            title_task = counter.calculate(title_size, self.config_content.color.text_color, 815, 80, 280, 80, title)
            desc_text1_task = counter.calculate(desc_size, self.config_content.color.sub_font_color, 815, 150, 280, 150,
                                                desc_text1)
            return await asyncio.gather(title_task, desc_text1_task)

    async def get_cover(self, cover_url):
        cover = PicGetter().pic_getter(cover_url, "PIL")
        return [{"info_type": "img", "content": cover, "position": (60, 50)}]

    async def make_btn(self, button):
        if button.status:
            text = button.uncheck.text if button.status == 1 else button.check.text
        else:
            text = button.jump_style.text
        btn = Image.new("RGBA", (165, 70), self.config_content.color.bili_pink)
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        text_size = font.getsize(text)
        x = int((165 - text_size[0]) / 2) + 840
        y = int((70 - text_size[1]) / 2) + 105

        return [{"info_type": "img", "content": btn, "position": (840, 110)}, {"info_type": "text", "content": text,
                                                                               "position": (x, y),
                                                                               "font_color": "#ffffff"}]


class ADDITIONAL_UGC(ConfigReader, AbstractAdditionalRender):
    def __init__(self):
        super().__init__()
        self.background = None

    async def run(self, additional_item, forward: bool) -> Union[ndarray, None]:
        try:
            if forward:
                self.background = Image.new("RGBA", (1080, 28), self.config_content.color.forward_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 260)), fill=self.config_content.color.backgroud_color,
                              outline='#e5e9ef',
                              width=2)
            else:
                self.background = Image.new("RGBA", (1080, 280), self.config_content.color.backgroud_color)
                img = ImageDraw.ImageDraw(self.background)
                img.rectangle(((35, 20), (1045, 260)), fill=self.config_content.color.forward_color,
                              outline='#e5e9ef',
                              width=2)
            text_position_task = self.get_text_position(additional_item.ugc.title, additional_item.ugc.desc_text_2)
            cover_position_task = self.get_cover_info(f"{additional_item.ugc.cover}@340w_195h.webp")
            duration_position_task = self.make_duration_img(additional_item.ugc.duration)
            result = await asyncio.gather(text_position_task, cover_position_task, duration_position_task)
            title_size = self.config_content.size.main_size
            desc_size = self.config_content.size.sub_size
            draw = DrawPic()
            title_task = draw.run(title_size, self.background, result[0][0])
            desc_task = draw.run(desc_size, self.background, result[0][1])
            cover_task = draw.run(img=self.background, img_info=result[1])
            duration_task = draw.run(desc_size, self.background, result[2])
            await asyncio.gather(title_task, desc_task, cover_task, duration_task)
            return cv.cvtColor(numpy.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    async def get_text_position(self, title, desc):
        title_size = self.config_content.size.main_size
        desc_size = self.config_content.size.sub_size
        counter = TextCalculate()
        title_task = counter.calculate(title_size, self.config_content.color.text_color, 1000, 130, 430, 65, title)
        desc_text_task = counter.calculate(desc_size, self.config_content.color.sub_font_color, 1000, 190, 430, 190,
                                           desc)
        return await asyncio.gather(title_task, desc_text_task)

    async def get_cover_info(self, cover):
        cover = PicGetter().pic_getter(cover, "PIL")
        return [{"info_type": "img", "content": cover, "position": (60, 45)}]

    async def make_duration_img(self, duration):
        font_path = path.join(getcwd(), "Static", "Font", self.config_content.font.main_font_name)
        font = ImageFont.truetype(font_path, self.config_content.size.sub_size)
        duration_size = font.getsize(duration)
        bk_pic_size = (duration_size[0] + 20, duration_size[1] + 20)
        bk_pic = Image.new("RGBA", bk_pic_size, (0, 0, 0, 90))
        return [{"info_type": "img", "content": bk_pic, "position": (250, 165)},
                {"info_type": "text", "content": duration,
                 "position": (260, 170),
                 "font_color": "#ffffff"}]


class AdditionalRender(AbstractAddition):
    async def addition_render(self, additional_item, forward=False) -> Union[ndarray, None]:
        try:
            type_map = {2: "ADDITIONAL_GOODS", 3: "ADDITIONAL_VOTE", 4: "ADDITIONAL_COMMON", 7: "ADDITIONAL_UGC",
                        8: "ADDITIONAL_RESERVE"}
            additional_name = type_map[additional_item.type]
            return await eval(f"{additional_name}()").run(additional_item, forward)
        except KeyError as e:
            logger.exception("What?!")
            logger.error("未知类型Additional渲染错误")

        except Exception as e:
            logger.exception("What?!")
            logger.error("Additional渲染错误")
            return
