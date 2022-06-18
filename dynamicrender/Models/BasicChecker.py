from typing import Optional

from pydantic import BaseModel


# 一级
class LikeIcon(BaseModel):
    action_url: Optional[str] = None
    end_url: Optional[str] = None
    id: Optional[int] = None
    start_url: Optional[str] = None
    rid_str: Optional[str] = None


class Basic(BaseModel):
    comment_id_str: Optional[str]
    comment_type: Optional[int]
    like_icon: Optional[LikeIcon] = None
