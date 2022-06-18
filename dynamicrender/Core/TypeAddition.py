from abc import ABCMeta,abstractmethod
from ..Models.ModulesChecker import ModuleDynamic
from .Config import ConfigReader

class AbstractAddition(metaclass = ABCMeta):
    @abstractmethod
    async def addition_render(self,additional_item:ModuleDynamic.additional):
        pass