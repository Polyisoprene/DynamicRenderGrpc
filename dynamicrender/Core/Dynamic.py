# -*- encoding: utf-8 -*-
"""
@File    :   Dynamic.py
@Time    :   2022/05/29 21:42:42
@Author  :   DMC
"""

import asyncio
import shutil
from abc import ABCMeta, abstractmethod
from os import path, getcwd, listdir, makedirs, mkdir

import cv2 as cv
import numpy as np
import sys
from loguru import logger

from .TypeFooter import Footer
from .TypeHeader import Header
from .TypeMajor import MajorRender
from .TypeText import Text
from .TypeTopic import Topic
from ..bilibili.app.dynamic.v2.dynamic_pb2 import DynamicItem

# from ..Models import Item

# region
# dyn_none = 0;          // 占位
# forward = 1;           // 转发
# av = 2;                // 稿件: ugc、小视频、短视频、UGC转PGC
# pgc = 3;               // pgc：番剧、PGC番剧、PGC电影、PGC电视剧、PGC国创、PGC纪录片
# courses = 4;           // 付费更新批次 待添加
# fold = 5;              // 折叠
# word = 6;              // 纯文字
# draw = 7;              // 图文
# article = 8;           // 专栏 原仅phone端
# music = 9;             // 音频 原仅phone端
# common_square = 10;    // 通用卡 方形
# common_vertical = 11;  // 通用卡 竖形
# live = 12;             // 直播卡 只有转发态
# medialist = 13;        // 播单 原仅phone端 只有转发态
# courses_season = 14;   // 付费更新批次 只有转发态
# ad = 15;               // 广告卡
# applet = 16;           // 小程序卡
# subscription = 17;     // 订阅卡
# live_rcmd = 18;        // 直播推荐卡
# banner = 19;           // 通栏
# ugc_season = 20;       // 合集卡
# subscription_new = 21; // 新订阅卡
# story = 22;            //
# topic_rcmd = 23;       //

# endregion

logger.remove()
logger.add(sys.stdout,
           format="<red>[</red><green>{time:YYYY/MM/DD HH:mm:ss}</green><red>]</red> <red>[</red> <green>{level}</green> <red>]</red> {message}")


class ConfigInit:
    def __init__(self) -> None:
        self.init_static_file()

    def init_static_file(self) -> None:
        """初始化静态文件"""
        package_path = path.dirname(path.dirname(path.abspath(__file__)))
        running_path = getcwd()
        if not path.exists(path.join(running_path, "Static")):
            logger.info("检测到缺失静态文件")
            logger.info("开始生成静态文件目录")
            mkdir(path.join(running_path, "Static"))
            self.generate_static_file(
                path.join(package_path, "Static"), path.join(running_path, "Static"))
            logger.info("静态文件创建完毕")

    def generate_static_file(self, from_file, to_file) -> None:
        """
        拷贝静态目录至程序运行目录
        :param from_file: 源静态目录的路径
        :type from_file: path
        :param to_file: 程序运行目录
        :type to_file: path
        """

        if not path.exists(to_file):
            makedirs(to_file)
        files = listdir(from_file)
        for f in files:
            if path.isdir(f'{from_file}/{f}'):
                self.generate_static_file(f'{from_file}/{f}', f'{to_file}/{f}')
            else:
                shutil.copy(f'{from_file}/{f}', f'{to_file}/{f}')


class AbstractRun(metaclass=ABCMeta):
    @abstractmethod
    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass

    @abstractmethod
    async def run(self, item: DynamicItem) -> bytes:
        """各个种类的动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_WORD(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: DynamicItem
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """

        module_type_list = [module.module_type for module in item.modules]
        tasks = [Header().header_render(item.modules[0].module_author)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic))

        if 3 in module_type_list:
            topic_index = module_type_list.index(3)
            tasks.insert(topic_index, Text().text_render(item.modules[topic_index].module_desc))

        tasks.append(Footer().footer_render(item.extend.dyn_id_str))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        if len(pic_list) == 1:
            return np.array(cv.imencode('.png', pic_list[0])[1]).tobytes()
        img = cv.vconcat(pic_list)
        return np.array(cv.imencode('.png', img)[1]).tobytes()


class DYNAMIC_TYPE_DRAW(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: DynamicItem
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [Header().header_render(item.modules[0].module_author), Footer().footer_render(item.extend.dyn_id_str)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        if len(pic_list) == 1:
            return np.array(cv.imencode('.png', pic_list[0])[1]).tobytes()
        img = cv.vconcat(pic_list)
        return np.array(cv.imencode('.png', img)[1]).tobytes()


class DYNAMIC_TYPE_AV(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [Header().header_render(item.modules[0].module_author), Footer().footer_render(item.extend.dyn_id_str)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        if len(pic_list) == 1:
            return np.array(cv.imencode('.png', pic_list[0])[1]).tobytes()
        img = cv.vconcat(pic_list)
        return np.array(cv.imencode('.png', img)[1]).tobytes()


class DYNAMIC_TYPE_LIVE_RCMD(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_LIVE(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_ARTICLE(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: DynamicItem
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_COMMON_VERTICAL(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_COURSES_SEASON(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_MEDIALIST(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_PGC(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_MUSIC(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_COMMON_SQUARE(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class DYNAMIC_TYPE_FORWARD(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        pass

    async def assemble(self, pic_list: list) -> bytes:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        pass


class Render(ConfigInit):
    def __init__(self) -> None:
        super().__init__()

    async def run(self, dynamic: DynamicItem) -> bytes:
        """
        入口函数
        :param dynamic:
        :return:
        """
        try:
            type_map = {0: "DYNAMIC_TYPE_NONE", 1: "DYNAMIC_TYPE_FORWARD", 2: "DYNAMIC_TYPE_AV", 3: "DYNAMIC_TYPE_PGC",
                        6: "DYNAMIC_TYPE_WORD", 7: "DYNAMIC_TYPE_DRAW", 8: "DYNAMIC_TYPE_ARTICLE",
                        9: "DYNAMIC_TYPE_MUSIC", 10: "DYNAMIC_TYPE_COMMON_SQUARE", 11: "DYNAMIC_TYPE_COMMON_VERTICAL",
                        12: "DYNAMIC_TYPE_LIVE", 13: "DYNAMIC_TYPE_MEDIALIST", 14: "DYNAMIC_TYPE_COURSES_SEASON",
                        18: "DYNAMIC_TYPE_LIVE_RCMD"}

            type_name = type_map[dynamic.card_type]
            return await eval(f"{type_name}()").run(dynamic)

        except KeyError:
            logger.error("不支持的动态类型")

        except Exception as e:
            logger.exception("What?!")
            logger.error("动态渲染失败")
