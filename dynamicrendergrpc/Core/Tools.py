# -*- encoding: utf-8 -*-
"""
@File    :   Tools.py
@Time    :   2022/06/18 21:34:23
@Author  :   DMC
"""
import asyncio
import re
from io import BytesIO
from os import getcwd
from os import path
from typing import Union

import cv2 as cv
import emoji
import httpx
import numpy as np
from PIL import Image, ImageDraw
from PIL import ImageFont
from fontTools.ttLib import TTFont
from numpy import ndarray

from .Config import ConfigReader
from .Dynamic import logger


class PicGetter:
    def pic_getter(self, url, mode: str = "ndarry") -> Union[ndarray, Image.Image, None]:
        """请求图片的函数

        :param mode:
        :param url: 图片url
        :type url: str
        :return: 下载完成并被转换成四通道的ndarray数据
        :rtype: ndarray
        """
        try:
            if not re.match("(.*?).hdslb.com/bfs/",url).group():
                url = re.compile(r"@(.*?).webp").sub('', url)
            response = httpx.get(url)
            image = Image.open(BytesIO(response.content)).convert("RGBA")
            if mode != "ndarry":
                return image
            return cv.cvtColor(np.asarray(image), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            return None

    def convert_png(self, img: ndarray) -> ndarray:
        """将图片转化为四通道PNG

        :param img: ndarry格式的图片
        :type img: ndarray
        :return: ndarry格式的图片
        :rtype: ndarray
        """
        chennal = img.shape[2]
        if chennal != 3:
            return img
        # 分离jpg图像通道
        b_channel, g_channel, r_channel = cv.split(img)
        # 创建Alpha通道
        alpha_channel = np.ones(b_channel.shape, dtype=b_channel.dtype) * 255
        # 融合通道
        return cv.merge((b_channel, g_channel, r_channel, alpha_channel))


class TextCalculate(ConfigReader):
    def __init__(self):
        super().__init__()
        self.relative_path = getcwd()
        self.font_path = path.join(self.relative_path, "Static", "Font")
        self.main_font = None
        self.standby_font = None
        self.font_key = \
            TTFont(path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name),
                   fontNumber=0)[
                'cmap'].tables[0].ttFont.getBestCmap().keys()
        self.emoji_font = ImageFont.truetype(font=path.join(self.font_path, self.config_content.font.emoji_font_name),
                                             size=self.config_content.size.emoji_size)
        self.emoji_instead = ["അ", "ആ", "ഇ", "ഈ", "ഉ", "ഊ", "ഋ", "ഌ",
                              "എ", "ഏ", "ഐ", "ഒ", "ഓ", "ഔ", "ക", "ഖ",
                              "ഗ", "ഘ", "ങ", "ച", "ഛ", "ജ", "ഝ", "ഞ",
                              "ട", "ഠ", "ഡ", "ഢ", "ണ", "ത", "ഥ", "ദ"]

    async def calculate(self, font_size: int, font_color: str,
                        x_constraint: int, y_constraint: int,
                        start_x: int, start_y: int, text: str) -> Union[list, None]:
        """
        计算字的位置的入口函数
        :param font_color: 字体的颜色
        :param font_size: 字体的字号
        :param x_constraint: x方向约束
        :param y_constraint: y方向约束
        :param start_x: x方向起始位置
        :param start_y: y方向起始位置
        :param text: 字符串
        :return: 字体位置信息列表
        """
        try:

            all_emoji = await self.get_all_emoji(text)
            keys = {"font_size": font_size,
                    "x_constraint": x_constraint, "y_constraint": y_constraint,
                    "start_x": start_x, "start_y": start_y, "text": all_emoji["text"],
                    "emoji_list": all_emoji["emoji_text"], "font_color": font_color}
            return await self.calculate_text_position(**keys)
        except Exception as e:
            logger.error("计算文字错误")
            return

    async def calculate_text_position(self, **kwargs):
        """
        计算字的位置
        :param kwargs:
        :return:
        """
        text = kwargs["text"]
        font_size = kwargs["font_size"]
        font_color = kwargs["font_color"]
        emoji_text = kwargs["emoji_list"]
        start_x, start_y = kwargs["start_x"], kwargs["start_y"]
        x, y = start_x, start_y
        y_interval = int(font_size * 1.2)
        x_constraint, y_constraint = kwargs["x_constraint"], kwargs["y_constraint"]
        self.main_font = ImageFont.truetype(path.join(self.font_path, self.config_content.font.main_font_name),
                                            font_size)
        self.standby_font = ImageFont.truetype(path.join(self.font_path, self.config_content.font.standby_font_name),
                                               font_size)
        position_info = []
        for word in text:
            if word in {chr(65039)}:
                continue
            if word in emoji_text:
                img = emoji_text[word]
                position_info.append({"info_type": "img", "content": img, "position": (x, y + 5)})
                x += img.size[0]
                if x > x_constraint:
                    x = start_x
                    y += y_interval
                    if y > y_constraint:
                        position_info[-1] = {"info_type": "text", "content": "...",
                                             "position": position_info[-1]["position"], "font_color": font_color}
                        break
                continue
            position_info.append(
                {"info_type": "text", "content": word, "position": (x, y), "font_color": font_color})
            x += self.standby_font.getsize(word)[0] if ord(word) not in self.font_key else self.main_font.getsize(word)[0]
            if x > x_constraint:
                x = start_x
                y += y_interval
                if y > y_constraint:
                    position_info[-1] = {"info_type": "text", "content": "...",
                                         "position": position_info[-1]["position"], "font_color": font_color}
                    break
        return position_info

    async def get_all_emoji(self, text: str):
        """
        提取文字中所有的emoji
        :param text:
        :return:
        """
        emoji_text_list = list({i["emoji"] for i in emoji.emoji_lis(text)})
        emoji_text = await self.draw_emoji(emoji_text_list)
        for i, emoji_text_info in enumerate(emoji_text_list):
            text = text.replace(emoji_text_info, self.emoji_instead[i])
        text = text.replace("\n", "")
        return {"text": text, "emoji_text": emoji_text}

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
        img_size = min(size)
        img = Image.new("RGBA", (img_size, img_size))
        draw = ImageDraw.Draw(img)
        draw.text(xy=(0, 0), text=text, font=font, embedded_color=True)
        return img.resize((main_font_size, main_font_size))


class DrawPic(ConfigReader):
    """
    绘制文本及emoji
    """

    def __init__(self):
        super().__init__()
        self.relative_path = getcwd()

        self.font_key = \
        TTFont(path.join(self.relative_path, "Static", "Font", self.config_content.font.main_font_name), fontNumber=0)[
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
