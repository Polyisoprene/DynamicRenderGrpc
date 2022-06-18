from typing import Optional, Union, List, Any

from pydantic import BaseModel, AnyUrl, Json

# 五级


class LivePlayInfo(BaseModel):
    area_name: Optional[str]
    cover: Optional[AnyUrl]
    live_screen_type: Optional[int]
    live_start_time: Optional[int]
    live_status: Optional[int]
    online: Optional[int]
    room_id: Optional[int]
    title: Optional[str]


class LiveRecordInfo(BaseModel):
    pass


class JumpStyle(BaseModel):
    text: str


class AddOnCommonCheck(BaseModel):
    text: str


class ReserveCheck(BaseModel):
    text: str


# 四级
class Emoji(BaseModel):
    icon_url: Optional[AnyUrl]
    size: Optional[int]
    text: Optional[str]
    type: Optional[int]


class PicItem(BaseModel):
    height: Optional[int]
    width: Optional[int]
    size: Union[int, float, None]
    src: Optional[AnyUrl]


class Badge(BaseModel):
    bg_color: Optional[str]
    color: Optional[str]
    text: Optional[str]


class Stat(BaseModel):
    danmaku: Optional[str]
    play: Optional[str]


class Content(BaseModel):
    type: Optional[int] = None
    live_play_info: Optional[LivePlayInfo] = None
    live_record_info: Optional[LiveRecordInfo] = None


class AddOnDesc(BaseModel):
    style: Optional[int]
    text: Optional[str]
    visible: Optional[bool]


class GoodsItem(BaseModel):
    brief: Optional[str] = None
    cover: Optional[AnyUrl]
    name: Optional[str]
    price: Optional[str]
    jump_desc: Optional[str]


class RichGoods(BaseModel):
    type: int
    jump_url: str


class AddOnButton(BaseModel):
    type: int
    jump_url: Optional[str]
    jump_style: Optional[JumpStyle]
    check: Optional[AddOnCommonCheck]


class ReserveButton(BaseModel):
    check: Optional[ReserveCheck]
    status: Optional[int]
    type: Optional[int]
    uncheck: Optional[ReserveCheck]


# 三级
class Fan(BaseModel):
    color: Optional[str] = None
    is_fan: Optional[bool] = None


class RichTextDetail(BaseModel):
    goods: Optional[RichGoods]
    emoji: Optional[Emoji]
    jump_url: Union[AnyUrl, str, None] = None
    orig_text: Optional[str] = None
    text: Optional[str] = None
    # RICH_TEXT_NODE_TYPE_TEXT      文本
    # RICH_TEXT_NODE_TYPE_AT        At
    # RICH_TEXT_NODE_TYPE_VOTE      投票
    # RICH_TEXT_NODE_TYPE_TOPIC     话题
    # RICH_TEXT_NODE_TYPE_BV        Bv转视频
    # RICH_TEXT_NODE_TYPE_WEB       网页链接
    # RICH_TEXT_NODE_TYPE_LOTTERY   抽奖
    # RICH_TEXT_NODE_TYPE_GOODS     恰饭 640021213187407875
    # RICH_TEXT_NODE_TYPE_EMOJI     bili_emoji

    type: Optional[str] = None


class Draw(BaseModel):
    items: Optional[List[PicItem]]


class Archive(BaseModel):
    aid: Optional[str]
    badge: Optional[Badge]
    bvid: Optional[str]
    cover: Optional[AnyUrl]
    desc: Optional[str] = None
    duration_text: Optional[str]
    stat: Optional[Stat]
    title: Optional[Any] = None
    type: Optional[int]


class Article(BaseModel):
    covers: Optional[List[AnyUrl]]
    desc: Optional[str]
    id: Optional[int]
    label: Optional[str]
    title: Optional[str]


class Common(BaseModel):
    badge: Optional[Badge]
    biz_type: Optional[int] = None
    # |_biz_type
    #   |_0     活动       641222605723926534
    #   |_3     装扮       551309621391003098
    #   |_111   分享的游戏  645309310073569287
    #   |_131   歌单       639296660796604438
    #   |_141   频道       631743110398869511
    #   |_201   漫画       639302493349609508
    #   |_231   挂件       639301892067819543
    #   |_212   话题分享    644198519846993953
    cover: Optional[AnyUrl] = None
    desc: Optional[str] = None
    style: Optional[int] = None
    label: Optional[str] = None
    title: Optional[str]


class LiveRcmd(BaseModel):
    content: Optional[Json[Content]]
    reserve_type: Optional[int]


class Reserve(BaseModel):
    title: Optional[str]
    desc1: Optional[AddOnDesc] = None
    desc2: Optional[AddOnDesc] = None
    desc3: Optional[AddOnDesc] = None
    reserve_total: Optional[int]
    button: Optional[ReserveButton]


class Goods(BaseModel):
    head_text: Optional[str]
    items: Optional[List[GoodsItem]]


class AddOnCommon(BaseModel):
    button: Optional[AddOnButton]
    cover: Optional[AnyUrl]
    head_text: Optional[str]
    desc1: Optional[str] = None
    desc2: Optional[str] = None
    title: Optional[str] = None
    # |_sub_type
    #   |_game              638931657286484020
    #   |_official_activity 551289005548902075
    #   |_decoration        638611334350503973
    #   |_manga             637737411561914375
    #   |_ogv               639534382927839233
    #   |_pugv              446619415589621845
    sub_type: Optional[str] = None


class UGC(BaseModel):
    cover: Optional[AnyUrl]
    desc_second: Optional[str]
    duration: Optional[str]
    head_text: Optional[str] = None
    title: Optional[str]


class Vote(BaseModel):
    desc: Optional[str]
    join_num: Optional[int]


class Pgc(BaseModel):
    badge: Optional[Badge]
    cover: Optional[AnyUrl]
    stat: Optional[Stat]
    # sub_type
    # |_ 1:番剧   641142414407368736
    # |_ 2:电影   633983562923638785
    # |_ 3:纪录片 206604904945647689
    # |_ 5:电视剧 454130952617983540
    sub_type: Optional[int]
    title: Optional[str]


class MajorNone(BaseModel):
    tips: str


class MediaList(BaseModel):
    badge: Badge
    cover: str
    cover_type: int
    sub_title: str
    title: str


class Live(BaseModel):
    badge: Badge
    cover: Optional[str]
    desc_first: str
    desc_second: str
    title: str
    live_state: int
    reserve_type: int


class Courses(BaseModel):
    badge: Badge
    cover: Optional[str]
    desc: Optional[str]
    sub_title: Optional[str]
    title: Optional[str]


class Music(BaseModel):
    cover: str
    label: str
    title: str


# 二级
class Decorate(BaseModel):
    card_url: Union[AnyUrl, str, None]
    fan: Optional[Fan]
    name: Optional[str]
    type: Optional[int]


class OfficialVerify(BaseModel):
    desc: Optional[str] = None
    type: Optional[int]


class Pendant(BaseModel):
    expire: Optional[int]
    image: Union[AnyUrl, str, None]
    image_enhance: Union[AnyUrl, str, None]
    name: Optional[str]


class Vip(BaseModel):
    avatar_subscript: Optional[int]
    avatar_subscript_url: Union[AnyUrl, str, None]
    due_date: Optional[int]
    nickname_color: Optional[str]
    status: Optional[int]
    theme_type: Optional[int]
    type: Optional[int]


class Addition(BaseModel):
    # |_ADDITIONAL_TYPE_RESERVE 预约
    # |_ADDITIONAL_TYPE_GOODS 商品橱窗 640021213187407875
    # |_ADDITIONAL_TYPE_COMMON 漫画、游戏、动漫、装扮、官方活动等
    # | |_sub_type
    # |   |_游戏示例 638931657286484020 sub_type=game
    # |   |_官方活动示例 551289005548902075 sub_type = official_activity
    # |   |_装扮示例 638611334350503973 sub_type = decoration
    # |   |_漫画 示例 637737411561914375 sub_type = manga
    # |   |_动漫 示例 639534382927839233 sub_type = ogv
    # |   |_付费课程 446619415589621845 sub_type = pugv
    # |
    # |_ADDITIONAL_TYPE_UGC UGC 610622978014393724
    # |
    # |_ADDITIONAL_TYPE_VOTE 投票 611702685546788433

    type: Optional[str]
    # 预约专有
    reserve: Optional[Reserve] = None
    # 商品橱窗专有
    goods: Optional[Goods] = None
    # ADDITIONAL_TYPE_COMMON 专有
    common: Optional[AddOnCommon] = None
    # ADDITIONAL_TYPE_UGC 专有
    ugc: Optional[UGC] = None
    # 投票专有
    vote: Optional[Vote] = None


class Desc(BaseModel):
    text: Optional[str] = None
    rich_text_nodes: Optional[List[RichTextDetail]] = None


class Major(BaseModel):
    # 纯文本类型无major
    # MAJOR_TYPE_ARCHIVE    视频              203507842683697712
    # MAJOR_TYPE_LIVE_RCMD  直播
    # MAJOR_TYPE_DRAW       图片              643771535681650743
    # MAJOR_TYPE_ARTICLE    专栏              643999976413724675
    # MAJOR_TYPE_MUSIC      音乐类型           611350614197990095
    # MAJOR_TYPE_COMMON     装扮等             551309621391003098
    # MAJOR_TYPE_PGC        番剧、电影、纪录片   633983562923638785
    # MAJOR_TYPE_NONE       直播结束            641187318269476881
    # MAJOR_TYPE_MEDIALIST  收藏夹             645144864367837192
    # MAJOR_TYPE_LIVE       分享直播
    # MAJOR_TYPE_COURSES    付费课程
    type: Optional[str]
    # 图片类型动态专有
    draw: Optional[Draw]
    # 视频动态专有
    archive: Optional[Archive]
    # 专栏专有
    article: Optional[Article]
    # MAJOR_TYPE_COMMON 专有
    common: Optional[Common]
    # 直播动态专有
    live_rcmd: Optional[LiveRcmd]
    # MAJOR_TYPE_PGC 专有
    pgc: Optional[Pgc]
    # none
    none: Optional[MajorNone]
    # 收藏夹
    medialist: Optional[MediaList]
    # 分享直播
    live: Optional[Live]
    # 付费课程
    courses: Optional[Courses]
    # 音乐
    music: Optional[Music]


class Topic(BaseModel):
    id: Optional[int] = None
    name: Optional[str] = None
    jump_url: Union[AnyUrl, str, None] = None


# 一级
class ModuleAuthor(BaseModel):
    decorate: Optional[Decorate] = None
    face: Optional[str]
    face_nft: Optional[bool] = None
    following: Optional[int] = None
    jump_url: Union[AnyUrl, str, None] = None
    label: Optional[str] = None
    mid: Optional[int] = None
    name: Optional[str] = None
    official_verify: Optional[OfficialVerify] = None
    pendant: Optional[Pendant] = None
    pub_time: Optional[str] = None
    pub_ts: Optional[int] = None
    type: Optional[str] = None
    vip: Optional[Vip]


class ModuleDynamic(BaseModel):
    additional: Optional[Addition] = None
    desc: Optional[Desc] = None
    major: Optional[Major] = None
    topic: Optional[Topic] = None


# class ModuleMore(BaseModel):
#     pass
#
#
# class ModuleStat(BaseModel):
#     pass


# 入口
class Modules(BaseModel):
    module_author: Optional[ModuleAuthor] = None
    module_dynamic: Optional[ModuleDynamic] = None
    # module_more: Optional[ModuleMore]
    # module_stat: Optional[ModuleStat]
