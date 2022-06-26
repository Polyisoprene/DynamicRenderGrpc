# -*- encoding: utf-8 -*-
"""
@File    :   TypeFooter.py
@Time    :   2022/06/18 21:34:53
@Author  :   DMC
"""


from abc import ABCMeta, abstractmethod
from typing import Union

import cv2 as cv
import numpy as np
import qrcode
from PIL import Image, ImageFont, ImageDraw
from numpy import ndarray
from os import path, getcwd
from .Config import ConfigReader
from .Dynamic import logger


class AbstractFooter(metaclass=ABCMeta):
    @abstractmethod
    async def footer_render(self, dynamic_id: str) -> Union[None, ndarray]:
        pass


class Footer(AbstractFooter, ConfigReader):
    def __init__(self) -> None:
        super().__init__()

    async def footer_render(self, dynamic_id: str) -> Union[None, ndarray]:
        """渲染图片脚的入口函数

        :param dynamic_id: 动态ID
        :type dynamic_id: str
        :return: 图片的ndarray格式
        :rtype: Union[None, ndarray]
        """
        try:
            relative_path = getcwd()
            self.background = Image.new(
                "RGBA", (1080, 276), self.config_content.color.backgroud_color)
            qr = await self.make_qrcode(dynamic_id)
            bili_pic = Image.open(
                path.join(relative_path, "Static", "Picture", "bilibili.png")).convert("RGBA")
            bili_pic = bili_pic.resize(
                (int(bili_pic.size[0] / 4), int(bili_pic.size[1] / 4)))
            font = ImageFont.truetype(path.join(
                relative_path, "Static", "Font", self.config_content.font.main_font_name), 20, encoding='utf-8')
            draw = ImageDraw.Draw(self.background, "RGBA")
            draw.text((50, 200), "扫描二维码查看动态", font=font, fill="#ff4e80")
            self.background.paste(bili_pic, (50, 90), bili_pic)
            self.background.paste(qr, (860, 80), qr)

            return cv.cvtColor(np.asarray(self.background), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            logger.error("渲染图片尾错误")
            return None

    async def make_qrcode(self, dynamic_id: str) -> Image.Image:
        """生成二维码

        :param dynamic_id: 动态的ID
        :type dynamic_id: str
        :return: 二维码图片
        :rtype: Image.Image
        """
        qr = qrcode.QRCode(
            version=1, error_correction=qrcode.constants.ERROR_CORRECT_Q, box_size=3, border=1)
        qr.add_data(f"https://t.bilibili.com/{dynamic_id}")
        return qr.make_image(fill_color="black").convert("RGBA").resize((164, 164))
