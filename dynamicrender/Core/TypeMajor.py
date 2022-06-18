from abc import ABCMeta, abstractmethod
from concurrent.futures import ThreadPoolExecutor
from typing import Union, List

import cv2 as cv
import numpy as np
from PIL import Image
from numpy import ndarray

from bilibili.app.dynamic.v2.dynamic_pb2 import ModuleDynamic,MdlDynDrawItem
from .Config import ConfigReader
from .Dynamic import logger
from .Tools import PicGetter


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


class AbstractMajorRender(metaclass=ABCMeta):
    @abstractmethod
    async def major_render(self, major_item: ModuleDynamic) -> Union[None, ndarray]:
        pass


class AbstractMajor(metaclass=ABCMeta):
    @abstractmethod
    async def assemble(self, item: dict) -> ndarray:
        pass


class MAJOR_TYPE_DRAW(ConfigReader, AbstractMajor, PicGetter):
    def __init__(self) -> None:
        super().__init__()

    async def run(self, major_item: ModuleDynamic, forward: bool) -> ndarray:
        """渲染Draw类Major的入口函数

        :param major_item: major主体
        :type major_item: Major
        :param forward: 判断是否是转发动态的Major
        :type forward: bool
        :return: 渲染好的Major图片
        :rtype: ndarray
        """
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
        img_ndarray = self.pic_getter(img_url)
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


class MajorRender(AbstractMajorRender):
    def __init__(self) -> None:
        pass

    async def major_render(self, major_item: ModuleDynamic, forward: bool = False) -> Union[None, ndarray]:
        try:
            major_map = {5: "MAJOR_TYPE_DRAW"}
            major_name = major_map[major_item.type]
            return await eval(f"{major_name}()").run(major_item, forward)
        except KeyError:
            logger.error("未知类型major")
            return None
        except Exception as e:
            logger.exception("What?!")
            logger.error("Major渲染失败")
            return None
