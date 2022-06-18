from typing import Optional

from pydantic import BaseModel

from .BasicChecker import Basic
from .ModulesChecker import Modules
from .OriginChecker import Orig


class Item(BaseModel):
    id_str: str
    basic: Basic = None
    modules: Modules = None
    # DYNAMIC_TYPE_WORD             纯文本     640417892069802054
    # DYNAMIC_TYPE_DRAW             图片类型   644715500770689045
    # DYNAMIC_TYPE_AV               视频      643761914964344889
    # DYNAMIC_TYPE_LIVE_RCMD        直播
    # DYNAMIC_TYPE_ARTICLE          专栏      643999976413724675
    # DYNAMIC_TYPE_COMMON_VERTICAL  漫画      639302493349609508
    # DYNAMIC_TYPE_COURSES_SEASON   付费课程
    # DYNAMIC_TYPE_PGC              番剧、电影、纪录片等 633983562923638785
    # DYNAMIC_TYPE_MUSIC            音乐      611350614197990095
    # DYNAMIC_TYPE_COMMON_SQUARE    装扮      551309621391003098
    # DYNAMIC_TYPE_MEDIALIST        收藏      645144864359448578
    # DYNAMIC_TYPE_COMMON_SQUARE    游戏之类    645309310073569287

    type: str
    orig: Optional[Orig] = None
