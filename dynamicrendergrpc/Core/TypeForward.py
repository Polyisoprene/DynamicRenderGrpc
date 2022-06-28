# -*- coding: UTF-8 -*-
"""
@File    :   DynamicRender -> TypeForward.py
@IDE     :   PyCharm
@Time    :   2022/6/23 23:01
@Author  :   DMC ,
"""

import asyncio
from abc import ABCMeta, abstractmethod

import cv2 as cv
import numpy as np
from loguru import logger
from numpy import ndarray

from .TypeHeader import ForwardHeader
from .TypeMajor import MajorRender
from .TypeText import Text
from .TypeTopic import Topic
from ..bilibili.app.dynamic.v2.dynamic_pb2 import DynamicItem


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
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))

        if 3 in module_type_list:
            topic_index = module_type_list.index(3)
            tasks.insert(topic_index, Text().text_render(item.modules[topic_index].module_desc, True))

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
    async def run(self, item: DynamicItem) -> ndarray:
        """渲染的入口函数

        :param item: 动态的item部分
        :type item: DynamicItem
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, forward=True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index,
                         Text().text_render(item.modules[text_module_index].module_desc, forward=True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index,
                     MajorRender().major_render(item.modules[dynamic_index].module_dynamic, forward=True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_AV(AbstractRun):
    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index,
                     MajorRender().major_render(item.modules[dynamic_index].module_dynamic, forward=True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_LIVE_RCMD(AbstractRun):
    def __init__(self):
        super().__init__()

    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index,
                     MajorRender().major_render(item.modules[dynamic_index].module_dynamic, forward=True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_LIVE(AbstractRun):
    def __init__(self):
        super().__init__()

    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index,
                     MajorRender().major_render(item.modules[dynamic_index].module_dynamic, forward=True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_ARTICLE(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: DynamicItem
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
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
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_COMMON_VERTICAL(AbstractRun):
    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_COURSES_SEASON(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
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
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_MEDIA_LIST(AbstractRun):
    def __init__(self):
        super().__init__()

    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_PGC(AbstractRun):
    def __init__(self):
        super().__init__()

    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_MUSIC(AbstractRun):
    async def run(self, item: DynamicItem) -> ndarray:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
        if 23 in module_type_list:
            topic_index = module_type_list.index(23)
            tasks.insert(topic_index, Topic().topic_render(item.modules[topic_index].module_topic, True))
        if 3 in module_type_list:
            text_module_index = module_type_list.index(3)
            tasks.insert(text_module_index, Text().text_render(item.modules[text_module_index].module_desc, True))
        dynamic_index = module_type_list.index(4)
        tasks.insert(dynamic_index, MajorRender().major_render(item.modules[dynamic_index].module_dynamic, True))
        all_pic = await asyncio.gather(*tasks)
        temp = [i for i in all_pic if i is not None]
        return await self.assemble(temp)

    async def assemble(self, pic_list: list) -> ndarray:
        """将各个部分的图片组装成一个完整的图片

        :param pic_list: 装有所有图片的列表
        :type pic_list: list
        :return: 完整图片的二进制数据
        :rtype: bytes
        """
        return pic_list[0] if len(pic_list) == 1 else cv.vconcat(pic_list)


class DYNAMIC_TYPE_COMMON_SQUARE(AbstractRun):
    async def run(self, item: DynamicItem) -> bytes:
        """不同类型动态的渲染函数的入口函数

        :param item: 动态的item部分
        :type item: Item
        :return: 渲染完成后的图片的二进制数据
        :rtype: bytes
        """
        module_type_list = [module.module_type for module in item.modules]
        tasks = [ForwardHeader().header_render(item.modules[0].module_author_forward)]
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


class ForwardRender:

    async def run(self, dynamic: DynamicItem) -> bytes:
        """
        入口函数
        :param dynamic:
        :return:
        """
        try:
            type_map = {0: "DYNAMIC_TYPE_NONE", 2: "DYNAMIC_TYPE_AV", 3: "DYNAMIC_TYPE_PGC",
                        6: "DYNAMIC_TYPE_WORD", 7: "DYNAMIC_TYPE_DRAW", 8: "DYNAMIC_TYPE_ARTICLE",
                        9: "DYNAMIC_TYPE_MUSIC", 10: "DYNAMIC_TYPE_COMMON_SQUARE", 11: "DYNAMIC_TYPE_COMMON_VERTICAL",
                        12: "DYNAMIC_TYPE_LIVE", 13: "DYNAMIC_TYPE_MEDIA_LIST", 14: "DYNAMIC_TYPE_COURSES_SEASON",
                        18: "DYNAMIC_TYPE_LIVE_RCMD"}

            type_name = type_map[dynamic.card_type]
            return await eval(f"{type_name}()").run(dynamic)

        except KeyError:
            logger.error("不支持的动态类型")

        except Exception as e:
            logger.exception("What?!")
            logger.error("动态渲染失败")
