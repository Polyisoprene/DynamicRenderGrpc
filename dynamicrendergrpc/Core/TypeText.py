# -*- encoding: utf-8 -*-
"""
@File    :   TypeText.py
@Time    :   2022/06/18 21:35:29
@Author  :   DMC
"""
import asyncio
import re
from abc import ABCMeta, abstractmethod
from concurrent.futures import ThreadPoolExecutor
from io import BytesIO
from os import path, getcwd

import cv2 as cv
import emoji
import httpx
import numpy
from PIL import Image, ImageFont, ImageDraw
from fontTools.ttLib import TTFont

from ..bilibili.app.dynamic.v2.dynamic_pb2 import ModuleDesc
from .Config import ConfigReader
from .Dynamic import logger


class AbstractText(metaclass=ABCMeta):
    @abstractmethod
    async def text_render(self, dynamic_item: ModuleDesc):
        pass


class Text(AbstractText, ConfigReader):
    def __init__(self):
        super().__init__()
        self.draw = None
        self.relative_path = getcwd()
        self.main_font = ImageFont.truetype(
            path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name),
            self.config_content.size.main_size)
        self.standby_font = ImageFont.truetype(
            path.join(self.relative_path, "Static", "Font", self.config_content.font.standby_font_name),
            self.config_content.size.main_size)
        self.back_ground = None
        self.rich_text_Instead = ["ກ", "ຂ", "ຄ", "ງ", "ຈ", "ສ", "ຊ", "ຍ", "ດ",
                                  "ຕ", "ຖ", "ທ", "ນ", "ບ", "ປ", "ຜ", "ຝ", "ພ"]
        self.emoji_new_instead = ["ក", "ខ", "គ", "ឃ", "ង", "ច", "ឆ", "ជ",
                                  "ឈ", "ញ", "ដ", "ឋ", "ឌ", "ឍ", "ណ", "ត",
                                  "ថ", "ទ", "ធ", "ន", "ប", "ផ", "ព", "ភ",
                                  "ម", "យ", "រ", "ល", "វ", "ស", "ហ", "ឡ"]
        self.emoji_instead = ["അ", "ആ", "ഇ", "ഈ", "ഉ", "ഊ", "ഋ", "ഌ",
                              "എ", "ഏ", "ഐ", "ഒ", "ഓ", "ഔ", "ക", "ഖ",
                              "ഗ", "ഘ", "ങ", "ച", "ഛ", "ജ", "ഝ", "ഞ",
                              "ട", "ഠ", "ഡ", "ഢ", "ണ", "ത", "ഥ", "ദ"]

    async def text_render(self, dynamic_item: ModuleDesc, forward=False):
        """
        渲染文字的入口函数
        :param forward: 是否是转发
        :param dynamic_item:动态文字主体
        :return:
        """
        try:
            # 源文本
            text = dynamic_item.text
            # 获取源文本中所有的富文本的信息
            all_rich_info = await self.get_all_rich_text(text, dynamic_item.desc)
            # 所有的文字emoji
            all_emoji = list({i["emoji"] for i in emoji.emoji_lis(text)})
            # 将文本中的文字emoji（因为文字emoji可能是几个emoji组成的所以将组合emoji全部换成一个字）
            # 和B站的emoji（B站的emoji形如[夏卜卜_好耶]不好计算，将其换成一个字）
            result = await self.modify_text(all_rich_info["text"], all_rich_info["emoji_new"], all_emoji)
            text = result["text"]
            emoji_new = result["emoji_new"]
            emoji_text = result["emoji_text"]
            rich_index = await self.calculate_rich_index(text, all_rich_info["rich_text_content"])
            position_info = await self.calculate_text_index(text, emoji_new, emoji_text, rich_index, start_x=45,
                                                            start_y=10, x_constraint=1020)
            return await self.make_pic(position_info, forward)

        except Exception as e:
            logger.exception("What?!")
            logger.error("渲染文字错误")

    async def get_all_rich_text(self, text: str, rich_text_nodes: list) -> dict:
        """
        获取所有富文本
        :param text:
        :param rich_text_nodes:
        :return:
        """
        info_list = []
        emoji_info = []
        text = text.translate(str.maketrans({'\r': '', chr(65039): '', chr(65038): '', chr(8205): ''}))
        for rich_text in rich_text_nodes:

            # 话题/@
            if rich_text.type in {5, 2}:
                info_list.append(rich_text.text)
                continue
            # av/bv/小视频
            if rich_text.type in {7, 8, 12}:
                new_text = self.rich_text_Instead[0] + rich_text.text
                text = text.replace(f"https://b23.tv/{rich_text.orig_text}", new_text)
                text = text.replace(rich_text.orig_text, new_text)
                info_list.append(new_text)
                continue
            # 网址
            if rich_text.type == 13:
                new_text = (self.rich_text_Instead[1] + rich_text.text).replace(chr(8203),'')
                text = text.replace(rich_text.uri, new_text)
                info_list.append(new_text)
                continue
            # 抽奖
            if rich_text.type == 3:

                new_text = (self.rich_text_Instead[2] + rich_text.text).replace(chr(8203),'')

                text = text.replace(rich_text.orig_text, new_text)
                info_list.append(new_text)
                continue
            # 商品
            if rich_text.type in {6, 14}:
                new_text = (self.rich_text_Instead[3] + rich_text.text).replace(chr(8203),'')
                text = text.replace(rich_text.orig_text, new_text)
                info_list.append(new_text)
                continue
            # 投票
            if rich_text.type == 4:
                new_text = (self.rich_text_Instead[5] + rich_text.text).replace(chr(8203),'')
                text = text.replace(rich_text.orig_text, new_text)
                info_list.append(new_text)
                continue
            # 表情
            if rich_text.type == 9:
                emoji_info.append({"name": rich_text.text, "url": str(rich_text.uri)})
                continue

        return {"text": text, "rich_text_content": info_list, "emoji_new": emoji_info}

    async def modify_text(self, text: str, emoji_new_list: list, emoji_list: list) -> dict:
        """
        将文本中的emoji替换掉
        :param text:
        :param emoji_new_list:
        :param emoji_list:
        :return:
        """
        emoji_new_info_list = []
        for i in emoji_new_list:
            if i not in emoji_new_info_list:
                emoji_new_info_list.append(i)
        emoji_new = await self.get_emoji_new(emoji_new_info_list)
        emoji_text = await self.draw_emoji(emoji_list)
        for i, emoji_new_info in enumerate(emoji_new_info_list):
            text = text.replace(emoji_new_info["name"], self.emoji_new_instead[i])
        for i, emoji_text_info in enumerate(emoji_list):
            text = text.replace(emoji_text_info, self.emoji_instead[i])
        return {"text": text, "emoji_new": emoji_new, "emoji_text": emoji_text}

    async def get_emoji_new(self, emoji_new_list: list) -> dict:
        """
        获取emoji
        :param: emoji_new_list
        :return:
        """
        with ThreadPoolExecutor(max_workers=5) as pool:
            result = pool.map(self.emoji_reader, emoji_new_list)
        return {self.emoji_new_instead[i]: e for i, e in enumerate(result)}

    def emoji_reader(self, emoji_info: dict) -> Image.Image:
        """
        读取emoji或者请求emoji
        :param emoji_info:
        :return:
        """
        pic_size = int(self.config_content.size.main_size * 1.5)
        emoji_name = emoji_info["name"]
        emoji_path = path.join(self.relative_path, "Static", "Cache", "Emoji", f"{emoji_name}.png")
        if path.exists(emoji_path):
            emoji_pic = Image.open(emoji_path).convert("RGBA").resize((pic_size, pic_size))
        else:
            try:
                response = httpx.get(emoji_info["url"], timeout=800)
                img_content = response.content
                with open(emoji_path, "wb") as f:
                    f.write(img_content)
                emoji_pic = Image.open(BytesIO(response.content)).convert("RGBA").resize((pic_size, pic_size))
            except Exception as e:
                emoji_pic = Image.new("RGBA", (pic_size, pic_size), self.config_content.color.backgroud_color)
                logger.error("获取图片失败")
        return emoji_pic

    async def draw_emoji(self, emoji_list: list) -> dict:
        """
        将emoji_text画在图片上
        :param emoji_list:
        :return:
        """
        emoji_font_size = self.config_content.size.emoji_size
        emoji_font = ImageFont.truetype(
            path.join(self.relative_path, "Static", "Font", self.config_content.font.emoji_font_name), emoji_font_size)
        font_size = self.config_content.size.main_size
        result = await asyncio.gather(
            *[self.draw_emoji_extract(emoji_font, font_size, i) for i in emoji_list])
        return {self.emoji_instead[i]: c for i, c in enumerate(result)}

    async def draw_emoji_extract(self, font, main_font_size, text) -> Image.Image:
        """
        画emoji_text
        :param font: 字体
        :param main_font_size: 主体文字的尺寸，用于缩放emoji
        :param text: emoji文字
        :return:
        """
        size = font.getsize(text)
        img = Image.new("RGBA", size)
        draw = ImageDraw.Draw(img)
        draw.text(xy=(0, 0), text=text, font=font, embedded_color=True)
        return img.resize((main_font_size, main_font_size))

    async def calculate_rich_index(self, text, rich_text_info):
        """
        获取副文本所有文字的索引
        :param text: 源文本
        :param rich_text_info: 副文本列表
        :return:
        """
        particular_text_index_set = ()
        for rich_text_detail in rich_text_info:
            # 加号和括号会影响正则，所以转义掉
            rich_text_detail = rich_text_detail.replace("+", "\+").replace("(", "\(")
            for t in re.finditer(rich_text_detail, text):
                particular_text_index_set = particular_text_index_set + tuple(range(t.start(), t.end()))
        return set(particular_text_index_set)

    async def calculate_text_index(self, text: str, emoji_new: dict, emoji_text: dict, rich_index: set, start_x: int,
                                   start_y: int, x_constraint: int):
        """
        计算所有文字及emoji的位置
        :param text: 文本
        :param emoji_new: 带有B站的emoji信息的字典
        :param emoji_text: 带有emoji信息的字典
        :param rich_index: 富文本的索引集合
        :param start_x: 文本的起始x坐标
        :param start_y: 文本的起始y坐标
        :param x_constraint: x方向约束
        :return:
        """
        self.font_key = \
            TTFont(path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name),
                   fontNumber=0)[
                'cmap'].tables[0].ttFont.getBestCmap().keys()
        font_size = self.config_content.size.main_size
        font_color = self.config_content.color.text_color
        y_interval = int(1.5 * font_size)
        position_list = []
        x, y = start_x, start_y
        for i, word in enumerate(text):
            if word in self.rich_text_Instead:
                # 如果是抽奖图标、网页链接图标之类的
                position_list.append(
                    await self.rich_text_index_process(self.rich_text_Instead.index(word), x, y, font_size))
                x += int(font_size * 1.3)
                if x > x_constraint:
                    x = start_x
                    y += y_interval
                continue
            if word in emoji_new:
                # 如果是B站自带的emoji
                img = emoji_new[word]
                position_list.append({"info_type": "img", "content": img, "position": (x, y-5)})
                x += img.size[0]
                if x > x_constraint:
                    x = start_x
                    y += y_interval
                continue
            if word in emoji_text:
                # 如果是emoji_text
                img = emoji_text[word]
                position_list.append({"info_type": "img", "content": img, "position": (x, y + 5)})
                x += img.size[0]
                if x > x_constraint:
                    x = start_x
                    y += y_interval
                continue
            if text[i] == "\n":
                x = start_x
                y += y_interval
                continue
            position_info = await self.word_index_process(word, i, x, y, font_size, rich_index, x_constraint, start_x,
                                                          y_interval, font_color)
            x = position_info[0]
            y = position_info[1]
            position_list.append(position_info[2])
        return position_list

    async def rich_text_index_process(self, rich_text_index: int, x: int, y: int, font_size: int):
        tag_pic_list = {0: "play.png", 1: "link.png", 2: "lottery.png", 3: "taobao.png", 4: "new_topic.png",
                        5: "icon_vote.png"}
        img_size = int(font_size * 1.3)

        pic_path = path.join(self.relative_path, "Static", "Picture", tag_pic_list[rich_text_index])
        img = Image.open(pic_path).convert("RGBA").resize((img_size, img_size))

        return {"info_type": "img", "content": img, "position": (x, y + 3)}

    async def word_index_process(self, word: str, i, x: int, y: int, font_size, rich_index, x_constraint, start_x,
                                 y_interval, font_color):
        """
        对文字的坐标进行处理
        :param word: 文字
        :param i: 文字索引
        :param x: x坐标
        :param y: y坐标
        :param font_size: 文字的尺寸
        :param rich_index: 富文本的索引的集合
        :param x_constraint: x方向约束
        :param start_x: x方向起始坐标
        :param y_interval: y方向每行文字的间隔
        :param font_color: 文字颜色
        :return:
        """
        if i in rich_index:
            # 如果文字的索引在富文本的索引集合内
            position_info = {"info_type": "text", "content": word, "position": (x, y),
                             "font_color": "#00A0D8",
                             "font_size": font_size}
        else:
            position_info = {"info_type": "text", "content": word, "position": (x, y),
                             "font_color": font_color,
                             "font_size": font_size}
        # 如果这个文字的ascii码不被主字体所包含，就用备用的字体来计算x方向的偏移量
        if ord(word) not in self.font_key:
            x += self.standby_font.getsize(word)[0]
        else:
            x += self.main_font.getsize(word)[0]
        if x > x_constraint:
            x = start_x
            y += y_interval
        return [x, y, position_info]

    async def make_pic(self, position_info: list, forward):
        back_ground_color = self.config_content.color.backgroud_color if forward is False else self.config_content.color.forward_color
        if position_info:
            # 图片的h
            y = position_info[-1]["position"][1] + int(self.config_content.size.main_size * 1.5) + 20
            self.back_ground = Image.new("RGBA", (1080, y), back_ground_color)
            self.draw = ImageDraw.Draw(self.back_ground)
            await asyncio.gather(*[self.draw_img(i) for i in position_info])
            return cv.cvtColor(numpy.asarray(self.back_ground), cv.COLOR_RGBA2BGRA)
        else:
            return None

    async def draw_img(self, img_dict: dict):
        if img_dict["info_type"] == "text":
            if ord(img_dict["content"]) not in self.font_key:
                self.draw.text(img_dict["position"], img_dict["content"], fill=img_dict["font_color"],
                               font=self.standby_font)
            else:
                self.draw.text(img_dict["position"], img_dict["content"], fill=img_dict["font_color"],
                               font=self.main_font)
        else:
            img = img_dict["content"]
            self.back_ground.paste(img, img_dict["position"], img)
