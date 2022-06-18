from abc import ABCMeta, abstractmethod

from .Config import ConfigReader
from bilibili.app.dynamic.v2.dynamic_pb2 import ModuleTopic


class AbstractTopic(metaclass=ABCMeta):
    @abstractmethod
    async def topic_render(self, dynamic_item: ModuleTopic):
        pass


class Topic(AbstractTopic, ConfigReader):
    def __init__(self):
        super().__init__()

    async def topic_render(self, topic_item: ModuleTopic):
        # print(topic_item)
        pass
