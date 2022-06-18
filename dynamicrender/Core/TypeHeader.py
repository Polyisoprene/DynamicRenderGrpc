from abc import ABCMeta, abstractmethod
from concurrent.futures import ThreadPoolExecutor
from io import BytesIO
from os import path, getcwd
from typing import Union

import cv2 as cv
import httpx
import numpy as np
import time
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
from numpy import ndarray

from .Config import ConfigReader
from .Dynamic import logger
from ..bilibili.app.dynamic.v2.dynamic_pb2 import ModuleAuthor


class AbstractHeadedr(metaclass=ABCMeta):
    @abstractmethod
    async def header_render(self, auther: ModuleAuthor):
        pass


class Header(AbstractHeadedr, ConfigReader):
    def __init__(self) -> None:
        super().__init__()
        self.relative_path = getcwd()
        self.cache_path = path.join(self.relative_path, "Static", "Cache")
        self.font_path = path.join(
            self.relative_path, "Static", "Font", self.config_content.font.main_font_name)

    async def header_render(self, auther: ModuleAuthor) -> Union[ndarray, None]:
        """图片头的渲染入口函数

        :param auther: 动态作者的所有信息
        :type auther: ModuleAuthor
        """
        try:
            self.back_groud_img = Image.new(
                "RGBA", (1080, 400), self.config_content.color.backgroud_color)
            self.draw = ImageDraw.Draw(self.back_groud_img)
            completed_info = await self.auther_info_classification(auther=auther)
            text_list = completed_info[0]
            all_pic = await self.get_all_pic(completed_info[1], auther.author)
            info_list = text_list + all_pic
            for i in info_list:
                await self.assemble_img(i)
            return cv.cvtColor(np.asarray(self.back_groud_img), cv.COLOR_RGBA2BGRA)
        except Exception as e:
            logger.exception("What?!")
            logger.error("图片头渲染错误")
            return None

    async def auther_info_classification(self, auther: ModuleAuthor) -> list:
        """对信息进行分类

        :param auther: 所有信息
        :type auther: ModuleAuthor
        :return: 装有所有信息的列表
        :rtype: list
        """
        text_info_list = [{"type": "text",
                           "content": auther.author.name,
                           "size": self.config_content.size.uname_size,
                           "color": auther.author.vip.nickname_color or self.config_content.color.text_color,
                           "position": (200, 250)},
                          {
                              "type": "text",
                              "content": auther.ptime_label_text,
                              "size": self.config_content.size.main_size,
                              "color": self.config_content.color.sub_font_color,
                              "position": (200, 320)
                          }]

        url_info_list = [{"type": "face",
                          "url": f"{auther.author.face}@120w_120h_1c_1s.webp",
                          "path": path.join(self.cache_path, "Face", f"{auther.mid}.webp")}]

        if auther.author.pendant.image:
            url_info_list.append({
                "type": "pendant",
                "url": f"{auther.author.pendant.image}@210w_2100h.webp",
                "path": path.join(self.cache_path, "Pendant", f"{auther.author.pendant.name}.png")
            })

        return [text_info_list, url_info_list]

    async def get_all_pic(self, url_list: list, auther: ModuleAuthor) -> list:
        """获取所有图片

        :param url_list: 装有图片的url的列表
        :type url_list: list
        :param auther: 动态作者的信息
        :type auther: ModuleAuthor
        :return: 返回装有所有图片的列表
        :rtype: list
        """
        with ThreadPoolExecutor(max_workers=2) as pool:
            results = pool.map(self.pic_reader, url_list)
        pic_info = list(results)

        bili_logo = Image.open(path.join(self.relative_path, "Static", "Picture", "bilibili.png")).convert(
            "RGBA").resize((231, 105))

        pic_info.append({"type": "img", "content": bili_logo, "position": (433, 20)})

        if auther.official.type != -1:
            official_verify_path = [path.join(self.relative_path, "Static", "Picture", "official_yellow.png"),
                                    path.join(self.relative_path, "Static", "Picture", "official_blue.png")]
            img = Image.open(
                official_verify_path[auther.official.type]).resize((45, 45))
            pic_info.append(
                {"type": "img", "content": img, "position": (120, 330)})
        elif auther.vip:
            avatar_subscript = auther.vip.avatar_subscript
            if avatar_subscript and avatar_subscript != 0:
                avatar_path = {2: path.join(self.relative_path, "Static", "Picture", "small_vip.png"),
                               1: path.join(self.relative_path, "Static", "Picture", "big_vip.png")}[avatar_subscript]
                avatar_img = Image.open(avatar_path).resize(
                    (45, 45)).convert("RGBA")
                pic_info.append(
                    {"type": "img", "content": avatar_img, "position": (120, 330)})
        return pic_info

    def pic_reader(self, pic_info: dict) -> dict:
        """读取或请求图片

        :param pic_info: 装有图片信息的字典
        :type pic_info: dict
        """
        img_path = pic_info["path"]
        img_url = pic_info["url"]
        pic_type = pic_info["type"]
        if path.exists(img_path):
            if pic_type == "face":
                # 如果头像的修改时间大于一天，重新下载头像
                if time.time() - int(path.getmtime(img_path)) > 86400:
                    resp = httpx.get(img_url)
                    with open(img_path, "wb") as f:
                        f.write(resp.content)
                    img = cv.imdecode(np.asarray(
                        bytearray(resp.content), dtype="uint8"), cv.IMREAD_UNCHANGED)
                else:
                    img = cv.imread(img_path)
                return {"type": "img", "content": self.convert_circle(img), "position": (45, 245)}
            else:
                img = Image.open(img_path).convert("RGBA")
                return {"type": "img", "content": img, "position": (1, 202)}
        else:
            resp = httpx.get(img_url)
            with open(img_path, "wb") as f:
                f.write(resp.content)
            if pic_type != "face":
                return {"type": "img", "content": Image.open(BytesIO(resp.content)), "position": (1, 202)}
            img = cv.imdecode(np.asarray(
                bytearray(resp.content), dtype="uint8"), cv.IMREAD_UNCHANGED)
            return {"type": "img", "content": self.convert_circle(img), "position": (45, 245)}

    def convert_png(self, img: ndarray) -> ndarray:
        """将jpg转为png

        :param img: 头像
        :type img: ndarray
        :return: png图片
        :rtype: ndarray
        """
        chennal = img.shape[2]
        if chennal != 3:
            return img
        b_channel, g_channel, r_channel = cv.split(img)  # 剥离jpg图像通道
        alpha_channel = np.ones(
            b_channel.shape, dtype=b_channel.dtype) * 255  # 创建Alpha通道
        # 融合通道
        return cv.merge((b_channel, g_channel, r_channel, alpha_channel))

    def convert_circle(self, img: ndarray) -> Image.Image:
        """将头像转为圆形

        :param img: 头像
        :type img: ndarray
        :return: 处理后的图片
        :rtype: ndarray
        """
        # 要处理的图
        img = cv.resize(img, (121, 121), interpolation=cv.INTER_NEAREST)
        img = self.convert_png(img)
        # 遮罩
        img_mask = np.ones((121, 121, 4)) * (255, 255, 255, 0)
        cv.circle(img_mask, (61, 61), 60, (0, 0, 0, 255), -1)
        cv.circle(img, (61, 61), 58, (153, 114, 251, 255), 3)
        img[:, :, 3] = img_mask[:, :, 3]
        return Image.fromarray(cv.cvtColor(img, cv.COLOR_BGRA2RGBA))

    async def assemble_img(self, info_dict) -> None:
        info_type = info_dict["type"]
        if info_type == "text":
            font = ImageFont.truetype(self.font_path, size=info_dict["size"], encoding='utf-8')
            self.draw.text(xy=info_dict["position"], text=info_dict["content"], font=font,
                           fill=info_dict["color"])
        else:
            img = info_dict["content"]
            self.back_groud_img.paste(img, info_dict["position"], img)
