# -*- encoding: utf-8 -*-
"""
@File    :   Config.py
@Time    :   2022/06/18 21:35:54
@Author  :   DMC
"""


import json
from os import path, getcwd

from pydantic import BaseModel


class Color(BaseModel):
    backgroud_color: str
    forward_color: str
    text_color: str
    sub_font_color: str
    extra_color: str
    bili_pink: str


class FontName(BaseModel):
    main_font_name: str
    standby_font_name: str
    emoji_font_name: str


class Size(BaseModel):
    uname_size: int
    main_size: int
    sub_size: int
    emoji_size: int
    sub_title_size:int


class ConfigModel(BaseModel):
    color: Color
    font: FontName
    size: Size


class ConfigReader:
    def __init__(self) -> None:
        self.set_prop()

    def set_prop(self) -> None:
        """读取配置文件"""
        config_path = path.join(getcwd(), "Static", "config.json")
        with open(config_path, "r") as f:
            config_content = json.loads(f.read())
        self.config_content = ConfigModel(**config_content)
