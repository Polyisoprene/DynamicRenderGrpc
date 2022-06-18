from abc import ABCMeta, abstractmethod

from .Config import ConfigReader
from bilibili.app.dynamic.v2.dynamic_pb2 import ModuleDesc


class AbstractText(metaclass=ABCMeta):
    @abstractmethod
    async def text_render(self, dynamic_item: ModuleDesc):
        pass


class Text(AbstractText, ConfigReader):
    def __init__(self):
        super().__init__()

    async def text_render(self, dynamic_item: ModuleDesc):
        # print(dynamic_item)
        pass