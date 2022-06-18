from pydantic import BaseModel

from .BasicChecker import Basic
from .ModulesChecker import Modules


class Orig(BaseModel):
    id_str: str
    basic: Basic
    modules: Modules
    # DYNAMIC_TYPE_PGC              番剧、电影、纪录片等
    # DYNAMIC_TYPE_LIVE_RCMD        直播
    # DYNAMIC_TYPE_COURSES_SEASON   付费课程   440646043801479846
    # DYNAMIC_TYPE_AV               视频      643761914964344889
    # DYNAMIC_TYPE_MUSIC            音乐      611350614197990095
    # DYNAMIC_TYPE_WORD             纯文本     640417892069802054
    # DYNAMIC_TYPE_ARTICLE          专栏      643999976413724675
    # DYNAMIC_TYPE_COMMON_SQUARE    装扮      551309621391003098
    # DYNAMIC_TYPE_COMMON_VERTICAL  漫画      639302493349609508
    type: str
