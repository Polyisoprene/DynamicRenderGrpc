import asyncio
from abc import ABCMeta, abstractmethod
from os import getcwd
from os import path

import cv2 as cv
import numpy
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
from numpy import ndarray

from bilibili.app.dynamic.v2.dynamic_pb2 import ModuleTopic
from .Config import ConfigReader


class AbstractTopic(metaclass=ABCMeta):
    @abstractmethod
    async def topic_render(self, dynamic_item: ModuleTopic):
        pass


class Topic(AbstractTopic, ConfigReader):
    def __init__(self):
        super().__init__()

    async def topic_render(self, topic_item: ModuleTopic) -> ndarray:
        self.relative_path = getcwd()
        font_size = self.config_content.size.main_size
        self.back_groud_img = Image.new("RGBA", (1080, 2 * font_size), self.config_content.color.backgroud_color)
        await asyncio.gather(self.write_topic(topic_item), self.pase_img())
        return cv.cvtColor(numpy.asarray(self.back_groud_img), cv.COLOR_RGBA2BGRA)

    async def write_topic(self, topic_item: ModuleTopic) -> None:
        """
        像图片内写入文字
        :param topic_item:
        :return:
        """
        topic_name = topic_item.name
        font_name = self.config_content.font.main_font_name
        font_color = self.config_content.color.extra_color
        font_size = self.config_content.size.main_size
        font = ImageFont.truetype(path.join(self.relative_path, "Static", "Font", font_name), size=font_size)
        draw = ImageDraw.Draw(self.back_groud_img)
        x = 55 + font_size
        y = int((font_size) / 2)

        draw.text(xy=(x, y), text=topic_name, fill=font_color, font=font)

    async def pase_img(self) -> None:
        """
        向图片中贴上图标
        :return:
        """
        font_size = self.config_content.size.main_size
        topic_img = Image.open(path.join(self.relative_path, "Static", "Picture", "new_topic.png")).convert(
            "RGBA").resize((font_size, font_size))
        x = 45
        y = int((font_size) / 2) + 5

        self.back_groud_img.paste(topic_img, (x, y), topic_img)
