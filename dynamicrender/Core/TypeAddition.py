# -*- encoding: utf-8 -*-
"""
@File    :   TypeAddition.py
@Time    :   2022/06/18 21:34:41
@Author  :   DMC
"""


from abc import ABCMeta, abstractmethod
from .Config import ConfigReader


class AbstractAddition(metaclass=ABCMeta):
    @abstractmethod
    async def addition_render(self, additional_item):
        pass
