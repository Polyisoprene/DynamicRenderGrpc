
?,
google/protobuf/any.protogoogle.protobuf"6
Any
type_url (	RtypeUrl
value (RvalueBv
com.google.protobufBAnyProtoPZ,google.golang.org/protobuf/types/known/anypb?GPB?Google.Protobuf.WellKnownTypesJ?*
 ?
?
 2? Protocol Buffers - Google's data interchange format
 Copyright 2008 Google Inc.  All rights reserved.
 https://developers.google.com/protocol-buffers/

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:

     * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above
 copyright notice, this list of conditions and the following disclaimer
 in the documentation and/or other materials provided with the
 distribution.
     * Neither the name of Google Inc. nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


  

" ;
	
%" ;

# C
	
# C

$ ,
	
$ ,

% )
	
% )

& "
	

& "

' !
	
$' !
?
 | ?? `Any` contains an arbitrary serialized protocol buffer message along with a
 URL that describes the type of the serialized message.

 Protobuf library provides support to pack/unpack Any values in the form
 of utility functions or additional generated methods of the Any type.

 Example 1: Pack and unpack a message in C++.

     Foo foo = ...;
     Any any;
     any.PackFrom(foo);
     ...
     if (any.UnpackTo(&foo)) {
       ...
     }

 Example 2: Pack and unpack a message in Java.

     Foo foo = ...;
     Any any = Any.pack(foo);
     ...
     if (any.is(Foo.class)) {
       foo = any.unpack(Foo.class);
     }

  Example 3: Pack and unpack a message in Python.

     foo = Foo(...)
     any = Any()
     any.Pack(foo)
     ...
     if any.Is(Foo.DESCRIPTOR):
       any.Unpack(foo)
       ...

  Example 4: Pack and unpack a message in Go

      foo := &pb.Foo{...}
      any, err := anypb.New(foo)
      if err != nil {
        ...
      }
      ...
      foo := &pb.Foo{}
      if err := any.UnmarshalTo(foo); err != nil {
        ...
      }

 The pack methods provided by protobuf library will by default use
 'type.googleapis.com/full.type.name' as the type URL and the unpack
 methods only use the fully qualified type name after the last '/'
 in the type URL, for example "foo.bar.com/x/y.z" will yield type
 name "y.z".


 JSON
 ====
 The JSON representation of an `Any` value uses the regular
 representation of the deserialized, embedded message, with an
 additional field `@type` which contains the type URL. Example:

     package google.profile;
     message Person {
       string first_name = 1;
       string last_name = 2;
     }

     {
       "@type": "type.googleapis.com/google.profile.Person",
       "firstName": <string>,
       "lastName": <string>
     }

 If the embedded message type is well-known and has a custom JSON
 representation, that representation will be embedded adding a field
 `value` which holds the custom JSON in addition to the `@type`
 field. Example (for message [google.protobuf.Duration][]):

     {
       "@type": "type.googleapis.com/google.protobuf.Duration",
       "value": "1.212s"
     }




 |
?

  ??
 A URL/resource name that uniquely identifies the type of the serialized
 protocol buffer message. This string must contain at least
 one "/" character. The last segment of the URL's path must represent
 the fully qualified name of the type (as in
 `path/google.protobuf.Duration`). The name should be in a canonical form
 (e.g., leading "." is not accepted).

 In practice, teams usually precompile into the binary all types that they
 expect it to use in the context of Any. However, for URLs which use the
 scheme `http`, `https`, or no scheme, one can optionally set up a type
 server that maps type URLs to message definitions as follows:

 * If no scheme is provided, `https` is assumed.
 * An HTTP GET on the URL must yield a [google.protobuf.Type][]
   value in binary format, or produce an error.
 * Applications are allowed to cache lookup results based on the
   URL, or have them precompiled into a binary to avoid any
   lookup. Therefore, binary compatibility needs to be preserved
   on changes to types. (Use versioned type names to manage
   breaking changes.)

 Note: this functionality is not currently available in the official
 protobuf release, and it is not used for type URLs beginning with
 type.googleapis.com.

 Schemes other than `http`, `https` (or the empty scheme) might be
 used with implementation specific semantics.



  ?

  ?	

  ?
W
 ?I Must be a valid serialized protocol buffer of the above specified type.


 ?

 ?

 ?bproto3
?
0bilibili/app/archive/middleware/v1/preload.proto"bilibili.app.archive.middleware.v1"g

PlayerArgs
qn (Rqn
fnver (Rfnver
fnval (Rfnval

force_host (R	forceHostJ?
  

  

 +
 
   视频秒开参数



 

   清晰度


  	

  


  

 	 流版本


 		

 	


 	

  流类型


 	

 


 
d
 W 返回url是否强制使用域名
 0:不强制使用域名 1:http域名 2:https域名


 	

 


 bproto3
δ
dynamic.protobilibili.app.dynamic.v2google/protobuf/any.proto0bilibili/app/archive/middleware/v1/preload.proto"C
AdParam
ad_extra (	RadExtra

request_id (	R	requestId"?
AdditionCommon
	head_text (	RheadText
title (	Rtitle
	image_url (	RimageUrl
desc_text_1 (	R	descText1
desc_text_2 (	R	descText2
url (	RurlA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
	head_icon (	RheadIcon9
style	 (2#.bilibili.app.dynamic.v2.ImageStyleRstyle
type
 (	Rtype
	card_type (	RcardType"?
AdditionEsport:
style (2$.bilibili.app.dynamic.v2.EspaceStyleRstyle_
addition_esport_moba (2+.bilibili.app.dynamic.v2.AdditionEsportMobaH RadditionEsportMoba
type (	Rtype
	card_type (	RcardTypeB
item"?
AdditionEsportMoba
	head_text (	RheadText
title (	RtitleA

match_team (2".bilibili.app.dynamic.v2.MatchTeamR	matchTeamp
addition_esport_moba_status (21.bilibili.app.dynamic.v2.AdditionEsportMobaStatusRadditionEsportMobaStatus
uri (	RuriA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
	sub_title (	RsubTitle
type
 (	Rtype
	card_type (	RcardType
	head_icon (	RheadIcon"?
AdditionEsportMobaStatus}
 addition_esport_moba_status_desc (25.bilibili.app.dynamic.v2.AdditionEsportMobaStatusDescRadditionEsportMobaStatusDesc
title (	Rtitle
status (Rstatus
color (	Rcolor
night_color (	R
nightColor"k
AdditionEsportMobaStatusDesc
title (	Rtitle
color (	Rcolor
night_color (	R
nightColor"?
AdditionGoods
	rcmd_desc (	RrcmdDescC
goods_items (2".bilibili.app.dynamic.v2.GoodsItemR
goodsItems
	card_type (	RcardType
icon (	Ricon
uri (	Ruri
source_type (R
sourceType"?

AdditionUP
title (	RtitleF
desc_text_1 (2&.bilibili.app.dynamic.v2.HighlightTextR	descText1
desc_text_2 (	R	descText2
url (	RurlA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
	card_type (	RcardType#
reserve_total (RreserveTotalE
act_skin (2*.bilibili.app.dynamic.v2.AdditionalActSkinRactSkin
rid	 (Rrid!
lottery_type
 (RlotteryTypeE

desc_text3 (2&.bilibili.app.dynamic.v2.HighlightTextR	descText3
up_mid (RupMidF
	user_info (2).bilibili.app.dynamic.v2.AdditionUserInfoRuserInfo

dynamic_id (	R	dynamicId

show_text2 (R	showText2
dyn_type (RdynType
business_id (	R
businessId"?
AdditionUgc
	head_text (	RheadText
title (	Rtitle
cover (	Rcover
desc_text_1 (	R	descText1
desc_text_2 (	R	descText2
uri (	Ruri
duration (	Rduration
	line_feed (RlineFeed
	card_type	 (	RcardType":
AdditionUserInfo
name (	Rname
face (	Rface"?
AdditionVote
	image_url (	RimageUrl
title (	Rtitle
text_1 (	Rtext1
button_text (	R
buttonText
url (	Rurl"?
AdditionVote2W
addition_vote_type (2).bilibili.app.dynamic.v2.AdditionVoteTypeRadditionVoteType
vote_id (RvoteId
title (	Rtitle
label (	Rlabel
deadline (Rdeadline
	open_text (	RopenText

close_text (	R	closeText

voted_text (	R	votedText@
state	 (2*.bilibili.app.dynamic.v2.AdditionVoteStateRstateY
addition_vote_word
 (2).bilibili.app.dynamic.v2.AdditionVoteWordH RadditionVoteWordV
addition_vote_pic (2(.bilibili.app.dynamic.v2.AdditionVotePicH RadditionVotePicb
addition_vote_defaule (2,.bilibili.app.dynamic.v2.AdditionVoteDefauleH RadditionVoteDefaule
biz_type (RbizType
total (Rtotal
	card_type (	RcardType
tips (	Rtips
uri (	Ruri
is_voted (RisVoted

choice_cnt (R	choiceCnt0
defaule_select_share (RdefauleSelectShareB
item"+
AdditionVoteDefaule
cover (	Rcover"S
AdditionVotePic@
item (2,.bilibili.app.dynamic.v2.AdditionVotePicItemRitem"?
AdditionVotePicItem
opt_idx (RoptIdx
cover (	Rcover
is_vote (RisVote
total (Rtotal
persent (Rpersent
title (	Rtitle"
is_max_option (RisMaxOption"U
AdditionVoteWordA
item (2-.bilibili.app.dynamic.v2.AdditionVoteWordItemRitem"?
AdditionVoteWordItem
opt_idx (RoptIdx
title (	Rtitle
is_vote (RisVote
total (Rtotal
persent (Rpersent"
is_max_option (RisMaxOption"e
AdditionalActSkin
svga (	Rsvga

last_image (	R	lastImage

play_times (R	playTimes"?
AdditionalButton:
type (2&.bilibili.app.dynamic.v2.AddButtonTypeRtypeM

jump_style (2..bilibili.app.dynamic.v2.AdditionalButtonStyleR	jumpStyle
jump_url (	RjumpUrlH
uncheck (2..bilibili.app.dynamic.v2.AdditionalButtonStyleRuncheckD
check (2..bilibili.app.dynamic.v2.AdditionalButtonStyleRcheckG
status (2/.bilibili.app.dynamic.v2.AdditionalButtonStatusRstatusQ

click_type (22.bilibili.app.dynamic.v2.AdditionalButtonClickTypeR	clickType"{
AdditionalButtonInteractive
popups (	Rpopups
confirm (	Rconfirm
cancel (	Rcancel
desc (	Rdesc"S
AdditionalButtonShare
show (Rshow
icon (	Ricon
text (	Rtext"?
AdditionalButtonStyle
icon (	Ricon
text (	RtextV
interactive (24.bilibili.app.dynamic.v2.AdditionalButtonInteractiveRinteractiveD
bg_style (2).bilibili.app.dynamic.v2.AddButtonBgStyleRbgStyle
toast (	Rtoast?
disable (2%.bilibili.app.dynamic.v2.DisableStateRdisableD
share (2..bilibili.app.dynamic.v2.AdditionalButtonShareRshare"?
AdditionalPGC
	head_text (	RheadText
title (	Rtitle
	image_url (	RimageUrl
desc_text_1 (	R	descText1
desc_text_2 (	R	descText2
url (	RurlA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
	head_icon (	RheadIcon9
style	 (2#.bilibili.app.dynamic.v2.ImageStyleRstyle
type
 (	Rtype"e
AlumniDynamicsReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
toast (	Rtoast"?
AlumniDynamicsReq
	campus_id (RcampusId

first_time (R	firstTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime
page (Rpage"C
CampusBannerInfo
image (	Rimage
jump_url (	RjumpUrl"?
CampusBillBoardReply
title (	Rtitle
help_uri (	RhelpUri
campus_name (	R
campusName

build_time (R	buildTime!
version_code (	RversionCode9
list (2%.bilibili.app.dynamic.v2.OfficialItemRlist
	share_uri (	RshareUri
bind_notice (R
bindNotice!
update_toast	 (	RupdateToast
	campus_id
 (RcampusId"?
CampusBillBoardReq
	campus_id (RcampusId!
version_code (	RversionCodeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"n
CampusBillboardInternalReq
mid (Rmid
	campus_id (RcampusId!
version_code (	RversionCode"{
CampusFeedbackInfo
biz_type (RbizType
biz_id (RbizId
	campus_id (RcampusId
reason (	Rreason"/
CampusFeedbackReply
message (	Rmessage"j
CampusFeedbackReqA
infos (2+.bilibili.app.dynamic.v2.CampusFeedbackInfoRinfos
from (Rfrom"v

CampusInfo
	campus_id (RcampusId
campus_name (	R
campusName
desc (	Rdesc
online (Ronline"G
CampusLabel
text (	Rtext
url (	Rurl
desc (	Rdesc"T
CampusMateLikeListReply9
list (2%.bilibili.app.dynamic.v2.ModuleAuthorRlist"6
CampusMateLikeListReq

dynamic_id (R	dynamicId"z
CampusNoticeInfo
title (	Rtitle
desc (	Rdesc<
button (2$.bilibili.app.dynamic.v2.CampusLabelRbutton"?
CampusRcmdFeedReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
toast (	RtoastB
	guide_bar (2%.bilibili.app.dynamic.v2.GuideBarInfoRguideBar
has_more (RhasMore
update (Rupdate"?
CampusRcmdFeedReq
	campus_id (RcampusId

first_time (R	firstTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime
page (Rpage
scroll (Rscroll
view_dyn_id (	R	viewDynId"e
CampusRcmdInfo
title (	Rtitle=
items (2'.bilibili.app.dynamic.v2.CampusRcmdItemRitems"?
CampusRcmdItem
title (	Rtitle7
items (2!.bilibili.app.dynamic.v2.RcmdItemRitems
	campus_id (RcampusIdE
entry_label (2$.bilibili.app.dynamic.v2.CampusLabelR
entryLabel"?
CampusRcmdReply8
top (2&.bilibili.app.dynamic.v2.CampusRcmdTopRtop;
rcmd (2'.bilibili.app.dynamic.v2.CampusRcmdInfoRrcmdA

campus_top (2".bilibili.app.dynamic.v2.CampusTopR	campusTop
	page_type (RpageType"?
CampusRcmdReq
	campus_id (RcampusId
campus_name (	R
campusName
lat (Rlat
lng (RlngO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"?
CampusRcmdTop
	campus_id (RcampusId
campus_name (	R
campusName
title (	Rtitle
desc (	Rdesc
type (Rtype>
button (2&.bilibili.app.dynamic.v2.RcmdTopButtonRbuttonG
switch_label (2$.bilibili.app.dynamic.v2.CampusLabelRswitchLabelG
notice_label (2$.bilibili.app.dynamic.v2.CampusLabelRnoticeLabel
desc2	 (	Rdesc2
desc3
 (	Rdesc3G
invite_label (2$.bilibili.app.dynamic.v2.CampusLabelRinviteLabelI
reserve_label (2$.bilibili.app.dynamic.v2.CampusLabelRreserveLabel%
reserve_number (RreserveNumber",
CampusRedDotReply
red_dot (RredDot".
CampusRedDotReq
	campus_id (RcampusId"f
CampusShowTabInfo
name (	Rname
url (	Rurl
type (Rtype
red_dot (RredDot"?
	CampusTop
	campus_id (RcampusId
campus_name (	R
campusName>
tabs (2*.bilibili.app.dynamic.v2.CampusShowTabInfoRtabsG
switch_label (2$.bilibili.app.dynamic.v2.CampusLabelRswitchLabel
title (	RtitleA
banner (2).bilibili.app.dynamic.v2.CampusBannerInfoRbannerG
invite_label (2$.bilibili.app.dynamic.v2.CampusLabelRinviteLabelA
notice (2).bilibili.app.dynamic.v2.CampusNoticeInfoRnoticeK
topic_square	 (2(.bilibili.app.dynamic.v2.TopicSquareInfoRtopicSquare!
campus_badge
 (	RcampusBadge+
campus_background (	RcampusBackground"?
CampusTopicRcmdFeedReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
toast (	Rtoast
has_more (RhasMore
offset (	Roffset"?
CampusTopicRcmdFeedReq
	campus_id (RcampusId
offset (	RoffsetO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime"?
CardVideoDynList8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist

update_num (R	updateNum%
history_offset (	RhistoryOffset'
update_baseline (	RupdateBaseline
has_more (RhasMore"v
CardVideoFollowList"
view_all_link (	RviewAllLink;
list (2'.bilibili.app.dynamic.v2.FollowListItemRlist"?
CardVideoUpList
title (	Rtitle7
list (2#.bilibili.app.dynamic.v2.UpListItemRlist
	footprint (	R	footprint"
show_live_num (RshowLiveNumG

more_label (2(.bilibili.app.dynamic.v2.UpListMoreLabelR	moreLabel!
title_switch (RtitleSwitch&
show_more_label (RshowMoreLabel(
show_in_personal (RshowInPersonal(
show_more_button	 (RshowMoreButton"?
ChannelInfo

channel_id (R	channelId!
channel_name (	RchannelName
desc (	Rdesc
is_atten (RisAtten
	type_icon (	RtypeIcon7
items (2!.bilibili.app.dynamic.v2.RcmdItemRitems
icon (	Ricon
jump_uri (	RjumpUri"a
CmtShowItem
uid (Ruid
uname (	Runame
uri (	Ruri
comment (	Rcomment"F
CommentDetail

can_modify (R	canModify
status (Rstatus"q
DecoCardFan
is_fan (RisFan
number (Rnumber

number_str (	R	numberStr
color (	Rcolor"?
DecorateCard
id (Rid
card_url (	RcardUrl
jump_url (	RjumpUrl6
fan (2$.bilibili.app.dynamic.v2.DecoCardFanRfan"?
Description
text (	Rtext5
type (2!.bilibili.app.dynamic.v2.DescTypeRtype
uri (	RuriA

emoji_type (2".bilibili.app.dynamic.v2.EmojiTypeR	emojiType

goods_type (	R	goodsType
icon_url (	RiconUrl
	icon_name (	RiconName
rid (	Rrid>
goods	 (2(.bilibili.app.dynamic.v2.ModuleDescGoodsRgoods
	orig_text
 (	RorigText

emoji_size (R	emojiSize"Q
	Dimension
height (Rheight
width (Rwidth
rotate (Rrotate"g
DynAdditionCommonFollowReplyG
status (2/.bilibili.app.dynamic.v2.AdditionalButtonStatusRstatus"?
DynAdditionCommonFollowReqG
status (2/.bilibili.app.dynamic.v2.AdditionalButtonStatusRstatus
dyn_id (	RdynId
	card_type (	RcardType"?
DynAllPersonalReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
offset (	Roffset
has_more (RhasMore
read_offset (	R
readOffset=
relation (2!.bilibili.app.dynamic.v2.RelationRrelationG
addition_up (2&.bilibili.app.dynamic.v2.TopAdditionUPR
additionUp"?
DynAllPersonalReq
host_uid (RhostUid
offset (	Roffset
page (Rpage

is_preload (R	isPreloadJ
playurl_param (2%.bilibili.app.dynamic.v2.PlayurlParamRplayurlParam

local_time (R	localTime
	footprint (	R	footprint
from (	RfromO
player_args	 (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"?
DynAllReplyG
dynamic_list (2$.bilibili.app.dynamic.v2.DynamicListRdynamicListA
up_list (2(.bilibili.app.dynamic.v2.CardVideoUpListRupListA

topic_list (2".bilibili.app.dynamic.v2.TopicListR	topicList=
unfollow (2!.bilibili.app.dynamic.v2.UnfollowRunfollowG
region_rcmd (2&.bilibili.app.dynamic.v2.DynRegionRcmdR
regionRcmd"?
	DynAllReq'
update_baseline (	RupdateBaseline
offset (	Roffset
page (RpageC
refresh_type (2 .bilibili.app.dynamic.v2.RefreshRrefreshTypeJ
playurl_param (2%.bilibili.app.dynamic.v2.PlayurlParamRplayurlParam'
assist_baseline (	RassistBaseline

local_time (R	localTimeK
rcmd_ups_param (2%.bilibili.app.dynamic.v2.RcmdUPsParamRrcmdUpsParam;
ad_param	 (2 .bilibili.app.dynamic.v2.AdParamRadParam

cold_start
 (R	coldStart
from (	RfromO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs$
tab_recall_uid (RtabRecallUid&
tab_recall_type (RtabRecallType"n
DynAllUpdOffsetReq
host_uid (RhostUid
read_offset (	R
readOffset
	footprint (	R	footprint"J
DynDetailReply8
item (2$.bilibili.app.dynamic.v2.DynamicItemRitem"?
DynDetailReq
uid (Ruid

dynamic_id (	R	dynamicId
dyn_type (RdynType
rid (Rrid;
ad_param (2 .bilibili.app.dynamic.v2.AdParamRadParam
from (	RfromO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs
share_id (	RshareId

share_mode	 (R	shareMode

local_time
 (R	localTime
pattern (	Rpattern"K
DynDetailsReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist"?
DynDetailsReq
dynamic_ids (	R
dynamicIdsJ
playurl_param (2%.bilibili.app.dynamic.v2.PlayurlParamRplayurlParam

local_time (R	localTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"L
DynFakeCardReply8
item (2$.bilibili.app.dynamic.v2.DynamicItemRitem"*
DynFakeCardReq
content (	Rcontent"X
DynLightReplyG
dynamic_list (2$.bilibili.app.dynamic.v2.DynamicListRdynamicList"?
DynLightReq%
history_offset (	RhistoryOffset
page (Rpage
from (	RfromO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime
	from_type (RfromType
fake_uid (RfakeUid"?
DynMixUpListViewMoreReply<
items (2&.bilibili.app.dynamic.v2.MixUpListItemRitems.
search_default_text (	RsearchDefaultText@

sort_types (2!.bilibili.app.dynamic.v2.SortTypeR	sortTypes/
show_more_sort_types (RshowMoreSortTypes*
default_sort_type (RdefaultSortType"6
DynMixUpListViewMoreReq
	sort_type (RsortType"?
DynRcmdReplyG
region_rcmd (2&.bilibili.app.dynamic.v2.DynRegionRcmdR
regionRcmdG
dynamic_list (2$.bilibili.app.dynamic.v2.DynamicListRdynamicList"?

DynRcmdReqO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime
fake_uid (RfakeUid

is_refresh (R	isRefresh"W
DynRcmdUpExchangeReply=
unfollow (2!.bilibili.app.dynamic.v2.UnfollowRunfollow"Z
DynRcmdUpExchangeReq
uid (Ruid
	dislikeTs (R	dislikeTs
from (	Rfrom"?
DynRegionRcmd@
items (2*.bilibili.app.dynamic.v2.DynRegionRcmdItemRitems7
opts (2#.bilibili.app.dynamic.v2.RcmdOptionRopts"v
DynRegionRcmdItem
rid (Rrid
title (	Rtitle9
items (2#.bilibili.app.dynamic.v2.ModuleRcmdRitems"?
DynSearchReplyI
channel_info (2&.bilibili.app.dynamic.v2.SearchChannelRchannelInfoG
search_topic (2$.bilibili.app.dynamic.v2.SearchTopicRsearchTopicD
search_info (2#.bilibili.app.dynamic.v2.SearchInfoR
searchInfo"?
DynSearchReq
keyword (	Rkeyword
page (Rpage

local_time (R	localTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"?
DynServerDetailsReplyO
items (29.bilibili.app.dynamic.v2.DynServerDetailsReply.ItemsEntryRitems^

ItemsEntry
key (Rkey:
value (2$.bilibili.app.dynamic.v2.DynamicItemRvalue:8"?
DynServerDetailsReq

local_time (R	localTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs
mobi_app (	RmobiApp
device (	Rdevice
buvid (	Rbuvid
build (Rbuild
mid (Rmid
platform	 (	Rplatform
	is_master
 (RisMaster"?
DynSpaceReq
host_uid (RhostUid%
history_offset (	RhistoryOffsetO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs

local_time (R	localTime
page (Rpage
from (	Rfrom"?
DynSpaceRsp8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist%
history_offset (	RhistoryOffset
has_more (RhasMore"?
DynSpaceSearchDetailsReplyT
items (2>.bilibili.app.dynamic.v2.DynSpaceSearchDetailsReply.ItemsEntryRitems^

ItemsEntry
key (Rkey:
value (2$.bilibili.app.dynamic.v2.DynamicItemRvalue:8"?
DynSpaceSearchDetailsReq!
search_words (	RsearchWords

local_time (R	localTimeO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs
mobi_app (	RmobiApp
device (	Rdevice
buvid (	Rbuvid
build (Rbuild
mid	 (Rmid
platform
 (	Rplatform
ip (	Rip
net_type (RnetType
tf_type (RtfType"?
DynTab
title (	Rtitle
uri (	Ruri
bubble (	Rbubble
	red_point (RredPoint
city_id (RcityId
is_popup (RisPopup4
popup (2.bilibili.app.dynamic.v2.PopupRpopup
default_tab (R
defaultTab
	sub_title	 (	RsubTitle
anchor
 (	Ranchor#
internal_test (	RinternalTest
type (Rtype8
back_up (2.bilibili.app.dynamic.v2.DynTabRbackUp"G
DynTabReply8
dyn_tab (2.bilibili.app.dynamic.v2.DynTabRdynTab"2
	DynTabReq%
teenagers_mode (RteenagersMode"?
DynThumbReq
uid (Ruid
dyn_id (	RdynId
dyn_type (RdynType
rid (	Rrid6
type (2".bilibili.app.dynamic.v2.ThumbTypeRtype"?
DynVideoPersonalReply8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
offset (	Roffset
has_more (RhasMore
read_offset (	R
readOffset=
relation (2!.bilibili.app.dynamic.v2.RelationRrelationG
addition_up (2&.bilibili.app.dynamic.v2.TopAdditionUPR
additionUp"?
DynVideoPersonalReq
host_uid (RhostUid
offset (	Roffset
page (Rpage

is_preload (R	isPreloadJ
playurl_param (2%.bilibili.app.dynamic.v2.PlayurlParamRplayurlParam

local_time (R	localTime
	footprint (	R	footprint
from (	RfromO
player_args	 (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"?
DynVideoReplyL
dynamic_list (2).bilibili.app.dynamic.v2.CardVideoDynListRdynamicListL
video_up_list (2(.bilibili.app.dynamic.v2.CardVideoUpListRvideoUpListX
video_follow_list (2,.bilibili.app.dynamic.v2.CardVideoFollowListRvideoFollowList"?
DynVideoReq'
update_baseline (	RupdateBaseline
offset (	Roffset
page (RpageC
refresh_type (2 .bilibili.app.dynamic.v2.RefreshRrefreshTypeJ
playurl_param (2%.bilibili.app.dynamic.v2.PlayurlParamRplayurlParam'
assist_baseline (	RassistBaseline

local_time (R	localTime
from (	RfromO
player_args	 (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"p
DynVideoUpdOffsetReq
host_uid (RhostUid
read_offset (	R
readOffset
	footprint (	R	footprint"`
DynVoteReply:
item (2&.bilibili.app.dynamic.v2.AdditionVote2Ritem
toast (	Rtoast"?

DynVoteReq
vote_id (RvoteId
votes (Rvotes;
status (2#.bilibili.app.dynamic.v2.VoteStatusRstatus

dynamic_id (	R	dynamicId
share (Rshare"?
DynamicItemA
	card_type (2$.bilibili.app.dynamic.v2.DynamicTypeRcardTypeA
	item_type (2$.bilibili.app.dynamic.v2.DynamicTypeRitemType9
modules (2.bilibili.app.dynamic.v2.ModuleRmodules7
extend (2.bilibili.app.dynamic.v2.ExtendRextend
has_fold (RhasFold
server_info (	R
serverInfo"?
DynamicList8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist

update_num (R	updateNum%
history_offset (	RhistoryOffset'
update_baseline (	RupdateBaseline
has_more (RhasMore"?
ExtInfoCommon
title (	Rtitle
uri (	Ruri
icon (	Ricon
poi_type (RpoiType:
type (2&.bilibili.app.dynamic.v2.DynExtendTypeRtype

sub_module (	R	subModule
action_text (	R
actionText

action_url (	R	actionUrl
rid	 (Rrid"
is_show_light
 (RisShowLight"I
ExtInfoGame
title (	Rtitle
uri (	Ruri
icon (	Ricon"H

ExtInfoHot
title (	Rtitle
uri (	Ruri
icon (	Ricon"c

ExtInfoLBS
title (	Rtitle
uri (	Ruri
icon (	Ricon
poi_type (RpoiType"I

ExtInfoOGV;
info_ogv (2 .bilibili.app.dynamic.v2.InfoOGVRinfoOgv"J
ExtInfoTopic
title (	Rtitle
uri (	Ruri
icon (	Ricon"?
Extend

dyn_id_str (	RdynIdStr
business_id (	R
businessId%
orig_dyn_id_str (	RorigDynIdStr
	orig_name (	RorigName 
orig_img_url (	R
origImgUrlA
	orig_desc (2$.bilibili.app.dynamic.v2.DescriptionRorigDesc8
desc (2$.bilibili.app.dynamic.v2.DescriptionRdescH
orig_dyn_type (2$.bilibili.app.dynamic.v2.DynamicTypeRorigDynType

share_type	 (	R	shareType
share_scene
 (	R
shareScene"
is_fast_share (RisFastShare
r_type (RrType
dyn_type (RdynType
uid (Ruid
card_url (	RcardUrl;
source_content (2.google.protobuf.AnyRsourceContent
	orig_face (	RorigFace:
reply (2$.bilibili.app.dynamic.v2.ExtendReplyRreply"b
ExtendReply
uri (	RuriA
params (2).bilibili.app.dynamic.v2.ExtendReplyParamRparams":
ExtendReplyParam
key (	Rkey
value (	Rvalue"?
FollowListItem
	season_id (RseasonId
title (	Rtitle
cover (	Rcover
url (	Rurl5
new_ep (2.bilibili.app.dynamic.v2.NewEPRnewEp
	sub_title (	RsubTitle
pos (Rpos"?
	GoodsItem
cover (	Rcover.
schema_package_name (	RschemaPackageName
source_type (R
sourceType
jump_url (	RjumpUrl
	jump_desc (	RjumpDesc
title (	Rtitle
brief (	Rbrief
price (	Rprice
item_id	 (RitemId

schema_url
 (	R	schemaUrl&
open_white_list (	RopenWhiteList
user_web_v2 (R	userWebV2
ad_mark (	RadMark"?
GuideBarInfo
show (Rshow
page (Rpage
position (Rposition
desc (	Rdesc
	jump_page (RjumpPage#
jump_position (RjumpPosition"?
HighlightText
text (	RtextJ

text_style (2+.bilibili.app.dynamic.v2.HighlightTextStyleR	textStyle
jump_url (	RjumpUrl
icon (	Ricon"?
	IconBadge
icon_bg_url (	R	iconBgUrl
text (	Rtext"u

IconButton
text (	Rtext
	icon_head (	RiconHead
	icon_tail (	RiconTail
jump_uri (	RjumpUri"d
InfoOGV
title (	Rtitle
uri (	Ruri
icon (	Ricon

sub_module (	R	subModule"7
InteractionFace
mid (Rmid
face (	Rface"?
InteractionItemC
	icon_type (2&.bilibili.app.dynamic.v2.LocalIconTypeRiconType8
desc (2$.bilibili.app.dynamic.v2.DescriptionRdesc
uri (	Ruri

dynamic_id (	R	dynamicId
comment_mid (R
commentMid>
faces (2(.bilibili.app.dynamic.v2.InteractionFaceRfaces<
stat (2(.bilibili.app.dynamic.v2.InteractionStatRstat
icon	 (	Ricon"%
InteractionStat
like (Rlike"m
LikeAnimation
begin (	Rbegin
proc (	Rproc
end (	Rend 
like_icon_id (R
likeIconId"i
LikeInfoD
	animation (2&.bilibili.app.dynamic.v2.LikeAnimationR	animation
is_like (RisLike"?
LikeListReply9
list (2%.bilibili.app.dynamic.v2.ModuleAuthorRlist
has_more (RhasMore
total_count (R
totalCount"?
LikeListReq

dynamic_id (	R	dynamicId
dyn_type (RdynType
rid (Rrid

uid_offset (R	uidOffset
page (Rpage"D
LikeUser
uid (Ruid
uname (	Runame
uri (	Ruri"|
LiveInfo
	is_living (RisLiving
uri (	RuriA

live_state (2".bilibili.app.dynamic.v2.LiveStateR	liveState"T
LivePendant
text (	Rtext
icon (	Ricon

pendant_id (R	pendantId"|
	MatchTeam
id (Rid
name (	Rname
cover (	Rcover
color (	Rcolor
night_color (	R
nightColor"?
MdlDynApplet
id (Rid
uri (	Ruri
title (	Rtitle
	sub_title (	RsubTitle
cover (	Rcover
icon (	Ricon
label (	Rlabel!
button_title	 (	RbuttonTitle"?
MdlDynArchive
title (	Rtitle
cover (	Rcover
uri (	Ruri)
cover_left_text_1 (	RcoverLeftText1)
cover_left_text_2 (	RcoverLeftText2)
cover_left_text_3 (	RcoverLeftText3
avid (Ravid
cid (RcidA

media_type	 (2".bilibili.app.dynamic.v2.MediaTypeR	mediaType@
	dimension
 (2".bilibili.app.dynamic.v2.DimensionR	dimension9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge
can_play (RcanPlay8
stype (2".bilibili.app.dynamic.v2.VideoTypeRstype
isPGC (RisPGC
	inlineURL (	R	inlineURL
	EpisodeId (R	EpisodeId
SubType (RSubType 
PgcSeasonId (RPgcSeasonId
	play_icon (	RplayIcon
duration (Rduration
jump_url (	RjumpUrl

is_preview (R	isPreviewJ
badge_category (2#.bilibili.app.dynamic.v2.VideoBadgeRbadgeCategory

is_feature (R	isFeatureG
reserve_type (2$.bilibili.app.dynamic.v2.ReserveTypeRreserveType
bvid (	Rbvid
view (Rview"?
MdlDynArticle
id (Rid
uri (	Ruri
title (	Rtitle
desc (	Rdesc
covers (	Rcovers
label (	Rlabel

templateID (R
templateID"?
MdlDynCommon
oid (Roid
uri (	Ruri
title (	Rtitle
desc (	Rdesc
cover (	Rcover
label (	Rlabel
bizType (RbizType
sketchID (RsketchID?
style	 (2).bilibili.app.dynamic.v2.MdlDynCommonTypeRstyle9
badge
 (2#.bilibili.app.dynamic.v2.VideoBadgeRbadgeA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton"?
MdlDynCourBatch
title (	Rtitle
cover (	Rcover
uri (	Ruri
text_1 (	Rtext1
text_2 (	Rtext29
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge
	play_icon (	RplayIcon"?
MdlDynCourSeason
title (	Rtitle
cover (	Rcover
uri (	Ruri
text_1 (	Rtext1
desc (	Rdesc9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge
	play_icon (	RplayIcon"m

MdlDynDraw=
items (2'.bilibili.app.dynamic.v2.MdlDynDrawItemRitems
uri (	Ruri
id (Rid"?
MdlDynDrawItem
src (	Rsrc
width (Rwidth
height (Rheight
size (Rsize:
tags (2&.bilibili.app.dynamic.v2.MdlDynDrawTagRtags"?
MdlDynDrawTag>
type (2*.bilibili.app.dynamic.v2.MdlDynDrawTagTypeRtype>
item (2*.bilibili.app.dynamic.v2.MdlDynDrawTagItemRitem"?
MdlDynDrawTagItem
url (	Rurl
text (	Rtext
x (Rx
y (Ry 
orientation (Rorientation
source (Rsource
item_id (RitemId
mid (Rmid
tid	 (Rtid
poi
 (	Rpoi

schema_url (	R	schemaUrl"_
MdlDynForward8
item (2$.bilibili.app.dynamic.v2.DynamicItemRitem
rtype (Rrtype"?

MdlDynLive
id (Rid
uri (	Ruri
title (	Rtitle
cover (	Rcover
cover_label (	R
coverLabel!
cover_label2 (	RcoverLabel2A

live_state (2".bilibili.app.dynamic.v2.LiveStateR	liveState9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadgeG
reserve_type	 (2$.bilibili.app.dynamic.v2.ReserveTypeRreserveType"?
MdlDynLiveRcmd
content (	RcontentG
reserve_type (2$.bilibili.app.dynamic.v2.ReserveTypeRreserveType>
pendant (2$.bilibili.app.dynamic.v2.LivePendantRpendant"?
MdlDynMedialist
id (Rid
uri (	Ruri
title (	Rtitle
	sub_title (	RsubTitle
cover (	Rcover

cover_type (R	coverType9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge"?
MdlDynMusic
id (Rid
uri (	Ruri
up_id (RupId
title (	Rtitle
cover (	Rcover
label1 (	Rlabel1
upper (	Rupper"?
	MdlDynPGC
title (	Rtitle
cover (	Rcover
uri (	Ruri)
cover_left_text_1 (	RcoverLeftText1)
cover_left_text_2 (	RcoverLeftText2)
cover_left_text_3 (	RcoverLeftText3
cid (Rcid
	season_id (RseasonId
epid	 (Repid
aid
 (RaidA

media_type (2".bilibili.app.dynamic.v2.MediaTypeR	mediaType@
sub_type (2%.bilibili.app.dynamic.v2.VideoSubTypeRsubType

is_preview (R	isPreview@
	dimension (2".bilibili.app.dynamic.v2.DimensionR	dimension9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge
can_play (RcanPlay:
season (2".bilibili.app.dynamic.v2.PGCSeasonRseason
	play_icon (	RplayIcon
duration (Rduration
jump_url (	RjumpUrlJ
badge_category (2#.bilibili.app.dynamic.v2.VideoBadgeRbadgeCategory

is_feature (R	isFeature"?
MdlDynSubscription
id (Rid
ad_id (RadId
uri (	Ruri
title (	Rtitle
cover (	Rcover
ad_title (	RadTitle9
badge (2#.bilibili.app.dynamic.v2.VideoBadgeRbadge
tips (	Rtips"?
MdlDynSubscriptionNewI
style (23.bilibili.app.dynamic.v2.MdlDynSubscriptionNewStyleRstyleX
dyn_subscription (2+.bilibili.app.dynamic.v2.MdlDynSubscriptionH RdynSubscriptionM
dyn_live_rcmd (2'.bilibili.app.dynamic.v2.MdlDynLiveRcmdH RdynLiveRcmdB
item"?
MdlDynUGCSeason
title (	Rtitle
cover (	Rcover
uri (	Ruri)
cover_left_text_1 (	RcoverLeftText1)
cover_left_text_2 (	RcoverLeftText2)
cover_left_text_3 (	RcoverLeftText3
id (Rid
	inlineURL (	R	inlineURL
can_play	 (RcanPlay
	play_icon
 (	RplayIcon
avid (Ravid
cid (Rcid@
	dimension (2".bilibili.app.dynamic.v2.DimensionR	dimension
duration (Rduration
jump_url (	RjumpUrl"?
MixUpListItem
uid (Ruid+
special_attention (RspecialAttention!
reddot_state (RreddotStateG
	live_info (2*.bilibili.app.dynamic.v2.MixUpListLiveItemRliveInfo
name (	Rname
face (	RfaceC
official (2'.bilibili.app.dynamic.v2.OfficialVerifyRofficial2
vip (2 .bilibili.app.dynamic.v2.VipInfoRvip=
relation	 (2!.bilibili.app.dynamic.v2.RelationRrelation"V
MixUpListLiveItem
status (Rstatus
room_id (RroomId
uri (	Ruri"?
ModuleG
module_type (2&.bilibili.app.dynamic.v2.DynModuleTypeR
moduleTypeL
module_author (2%.bilibili.app.dynamic.v2.ModuleAuthorH RmoduleAuthorO
module_dispute (2&.bilibili.app.dynamic.v2.ModuleDisputeH RmoduleDisputeF
module_desc (2#.bilibili.app.dynamic.v2.ModuleDescH R
moduleDescO
module_dynamic (2&.bilibili.app.dynamic.v2.ModuleDynamicH RmoduleDynamicR
module_likeUser (2'.bilibili.app.dynamic.v2.ModuleLikeUserH RmoduleLikeUserL
module_extend (2%.bilibili.app.dynamic.v2.ModuleExtendH RmoduleExtendX
module_additional (2).bilibili.app.dynamic.v2.ModuleAdditionalH RmoduleAdditionalF
module_stat	 (2#.bilibili.app.dynamic.v2.ModuleStatH R
moduleStatF
module_fold
 (2#.bilibili.app.dynamic.v2.ModuleFoldH R
moduleFoldO
module_comment (2&.bilibili.app.dynamic.v2.ModuleCommentH RmoduleComment[
module_interaction (2*.bilibili.app.dynamic.v2.ModuleInteractionH RmoduleInteractionb
module_author_forward (2,.bilibili.app.dynamic.v2.ModuleAuthorForwardH RmoduleAuthorForward@
	module_ad (2!.bilibili.app.dynamic.v2.ModuleAdH RmoduleAdL
module_banner (2%.bilibili.app.dynamic.v2.ModuleBannerH RmoduleBannerS
module_item_null (2'.bilibili.app.dynamic.v2.ModuleItemNullH RmoduleItemNullV
module_share_info (2(.bilibili.app.dynamic.v2.ModuleShareInfoH RmoduleShareInfoU
module_recommend (2(.bilibili.app.dynamic.v2.ModuleRecommendH RmoduleRecommendC

module_top (2".bilibili.app.dynamic.v2.ModuleTopH R	moduleTopL
module_buttom (2%.bilibili.app.dynamic.v2.ModuleButtomH RmoduleButtomU
module_stat_forward (2#.bilibili.app.dynamic.v2.ModuleStatH RmoduleStatForwardI
module_story (2$.bilibili.app.dynamic.v2.ModuleStoryH RmoduleStoryI
module_topic (2$.bilibili.app.dynamic.v2.ModuleTopicH RmoduleTopici
module_topic_details_ext (2..bilibili.app.dynamic.v2.ModuleTopicDetailsExtH RmoduleTopicDetailsExtM
module_top_tag (2%.bilibili.app.dynamic.v2.ModuleTopTagH RmoduleTopTagY
module_topic_brief (2).bilibili.app.dynamic.v2.ModuleTopicBriefH RmoduleTopicBriefI
module_title (2$.bilibili.app.dynamic.v2.ModuleTitleH RmoduleTitleB
module_item"?
ModuleAdJ
module_author (2%.bilibili.app.dynamic.v2.ModuleAuthorRmoduleAuthor&
ad_content_type (RadContentType(
cover_left_text1 (	RcoverLeftText1(
cover_left_text2 (	RcoverLeftText2(
cover_left_text3 (	RcoverLeftText3"?
ModuleAdditional;
type (2'.bilibili.app.dynamic.v2.AdditionalTypeRtype:
pgc (2&.bilibili.app.dynamic.v2.AdditionalPGCH Rpgc>
goods (2&.bilibili.app.dynamic.v2.AdditionGoodsH Rgoods;
vote (2%.bilibili.app.dynamic.v2.AdditionVoteH RvoteA
common (2'.bilibili.app.dynamic.v2.AdditionCommonH RcommonA
esport (2'.bilibili.app.dynamic.v2.AdditionEsportH Resport>
vote2 (2&.bilibili.app.dynamic.v2.AdditionVote2H Rvote28
ugc	 (2$.bilibili.app.dynamic.v2.AdditionUgcH Rugc5
up
 (2#.bilibili.app.dynamic.v2.AdditionUPH Rup
rid (Rrid.
need_write_calender (RneedWriteCalenderB
item"?
ModuleAuthor
mid (Rmid(
ptime_label_text (	RptimeLabelText9
author (2!.bilibili.app.dynamic.v2.UserInfoRauthorJ
decorate_card (2%.bilibili.app.dynamic.v2.DecorateCardRdecorateCard
uri (	Ruri@
tp_list (2'.bilibili.app.dynamic.v2.ThreePointItemRtpListM

badge_type (2..bilibili.app.dynamic.v2.ModuleAuthorBadgeTypeR	badgeTypeS
badge_button (20.bilibili.app.dynamic.v2.ModuleAuthorBadgeButtonRbadgeButton
attend	 (Rattend=
relation
 (2!.bilibili.app.dynamic.v2.RelationRrelation7
weight (2.bilibili.app.dynamic.v2.WeightRweight
show_follow (R
showFollow
is_top (RisTop"i
ModuleAuthorBadgeButton
icon (	Ricon
title (	Rtitle
state (Rstate
id (Rid"?
ModuleAuthorForwardG
title (21.bilibili.app.dynamic.v2.ModuleAuthorForwardTitleRtitle
url (	Rurl
uid (Ruid(
ptime_label_text (	RptimeLabelText
show_follow (R
showFollow
face_url (	RfaceUrl=
relation (2!.bilibili.app.dynamic.v2.RelationRrelation@
tp_list (2'.bilibili.app.dynamic.v2.ThreePointItemRtpList"@
ModuleAuthorForwardTitle
text (	Rtext
url (	Rurl"?
ModuleBanner
title (	Rtitle=
type (2).bilibili.app.dynamic.v2.ModuleBannerTypeRtype?
user (2).bilibili.app.dynamic.v2.ModuleBannerUserH Ruser!
dislike_text (	RdislikeText!
dislike_icon (	RdislikeIconB
item"U
ModuleBannerUserA
list (2-.bilibili.app.dynamic.v2.ModuleBannerUserItemRlist"?
ModuleBannerUserItem
face (	Rface
name (	Rname
uid (RuidA

live_state (2".bilibili.app.dynamic.v2.LiveStateR	liveStateC
official (2'.bilibili.app.dynamic.v2.OfficialVerifyRofficial2
vip (2 .bilibili.app.dynamic.v2.VipInfoRvip
label (	RlabelA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
uri	 (	Ruri"T
ModuleButtomD
module_stat (2#.bilibili.app.dynamic.v2.ModuleStatR
moduleStat"W
ModuleCommentF
cmtShowItem (2$.bilibili.app.dynamic.v2.CmtShowItemRcmtShowItem"u

ModuleDesc8
desc (2$.bilibili.app.dynamic.v2.DescriptionRdesc
jump_uri (	RjumpUri
text (	Rtext"?
ModuleDescGoods
source_type (R
sourceType
jump_url (	RjumpUrl

schema_url (	R	schemaUrl
item_id (RitemId&
open_white_list (	RopenWhiteList
user_web_v2 (R	userWebV2
ad_mark (	RadMark.
schema_package_name (	RschemaPackageName"K
ModuleDispute
title (	Rtitle
desc (	Rdesc
uri (	Ruri"?

ModuleDynamic>
type (2*.bilibili.app.dynamic.v2.ModuleDynamicTypeRtypeI
dyn_archive (2&.bilibili.app.dynamic.v2.MdlDynArchiveH R
dynArchive=
dyn_pgc (2".bilibili.app.dynamic.v2.MdlDynPGCH RdynPgcS
dyn_cour_season (2).bilibili.app.dynamic.v2.MdlDynCourSeasonH RdynCourSeasonP
dyn_cour_batch (2(.bilibili.app.dynamic.v2.MdlDynCourBatchH RdynCourBatchI
dyn_forward (2&.bilibili.app.dynamic.v2.MdlDynForwardH R
dynForward@
dyn_draw (2#.bilibili.app.dynamic.v2.MdlDynDrawH RdynDrawI
dyn_article (2&.bilibili.app.dynamic.v2.MdlDynArticleH R
dynArticleC
	dyn_music	 (2$.bilibili.app.dynamic.v2.MdlDynMusicH RdynMusicF

dyn_common
 (2%.bilibili.app.dynamic.v2.MdlDynCommonH R	dynCommonM
dyn_common_live (2#.bilibili.app.dynamic.v2.MdlDynLiveH RdynCommonLiveO
dyn_medialist (2(.bilibili.app.dynamic.v2.MdlDynMedialistH RdynMedialistF

dyn_applet (2%.bilibili.app.dynamic.v2.MdlDynAppletH R	dynAppletX
dyn_subscription (2+.bilibili.app.dynamic.v2.MdlDynSubscriptionH RdynSubscriptionM
dyn_live_rcmd (2'.bilibili.app.dynamic.v2.MdlDynLiveRcmdH RdynLiveRcmdP
dyn_ugc_season (2(.bilibili.app.dynamic.v2.MdlDynUGCSeasonH RdynUgcSeasonb
dyn_subscription_new (2..bilibili.app.dynamic.v2.MdlDynSubscriptionNewH RdynSubscriptionNewB
module_item"c
ModuleExtendA
extend (2).bilibili.app.dynamic.v2.ModuleExtendItemRextend
uri (	Ruri"?
ModuleExtendItem:
type (2&.bilibili.app.dynamic.v2.DynExtendTypeRtypeM
ext_info_topic (2%.bilibili.app.dynamic.v2.ExtInfoTopicH RextInfoTopicG
ext_info_lbs (2#.bilibili.app.dynamic.v2.ExtInfoLBSH R
extInfoLbsG
ext_info_hot (2#.bilibili.app.dynamic.v2.ExtInfoHotH R
extInfoHotJ
ext_info_game (2$.bilibili.app.dynamic.v2.ExtInfoGameH RextInfoGameP
ext_info_common (2&.bilibili.app.dynamic.v2.ExtInfoCommonH RextInfoCommonG
ext_info_ogv (2#.bilibili.app.dynamic.v2.ExtInfoOGVH R
extInfoOgvB
extend"?

ModuleFold>
	fold_type (2!.bilibili.app.dynamic.v2.FoldTypeRfoldType
text (	Rtext
fold_ids (	RfoldIds@

fold_users (2!.bilibili.app.dynamic.v2.UserInfoR	foldUsers"h
ModuleInteractionS
interaction_item (2(.bilibili.app.dynamic.v2.InteractionItemRinteractionItem"8
ModuleItemNull
icon (	Ricon
text (	Rtext"u
ModuleLikeUser@

like_users (2!.bilibili.app.dynamic.v2.LikeUserR	likeUsers!
display_text (	RdisplayText"?

ModuleRcmd;
author (2#.bilibili.app.dynamic.v2.RcmdAuthorRauthor7
items (2!.bilibili.app.dynamic.v2.RcmdItemRitems
server_info (	R
serverInfo"?
ModuleRecommend!
module_title (	RmoduleTitle
image (	Rimage
tag (	Rtag
title (	Rtitle
jump_url (	RjumpUrl$
ad (2.google.protobuf.AnyRad"?
ModuleShareInfo
title (	RtitleL
share_channels (2%.bilibili.app.dynamic.v2.ShareChannelRshareChannels!
share_origin (	RshareOrigin
oid (	Roid
sid (	Rsid"?

ModuleStat
repost (Rrepost
like (Rlike
reply (Rreply>
	like_info (2!.bilibili.app.dynamic.v2.LikeInfoRlikeInfo

no_comment (R	noComment

no_forward (R	noForward
	reply_url (	RreplyUrl&
no_comment_text (	RnoCommentText&
no_forward_text	 (	RnoForwardText"?
ModuleStory
title (	Rtitle8
items (2".bilibili.app.dynamic.v2.StoryItemRitems2
show_publish_entrance (RshowPublishEntrance

fold_state (R	foldState
uri (	Ruri
cover (	Rcover!
publish_text (	RpublishText"e
ModuleTitle
title (	Rtitle@
	right_btn (2#.bilibili.app.dynamic.v2.IconButtonRrightBtn"M
	ModuleTop@
tp_list (2'.bilibili.app.dynamic.v2.ThreePointItemRtpList")
ModuleTopTag
tag_name (	RtagName"C
ModuleTopic
id (Rid
name (	Rname
url (	Rurl"L
ModuleTopicBrief8
topic (2".bilibili.app.dynamic.v2.TopicItemRtopic"<
ModuleTopicDetailsExt#
comment_guide (	RcommentGuide"?
	Nameplate
nid (Rnid
name (	Rname
image (	Rimage
image_small (	R
imageSmall
level (	Rlevel
	condition (	R	condition"L
NewEP
id (Rid

index_show (	R	indexShow
cover (	Rcover"	
NoReply"
NoReq"?
OfficialAccountInfo9
author (2!.bilibili.app.dynamic.v2.UserInfoRauthor
mid (Rmid
uri (	Ruri=
relation (2!.bilibili.app.dynamic.v2.RelationRrelation

desc_text1 (	R	descText1

desc_text2 (	R	descText2"?
OfficialAccountsReplyB
items (2,.bilibili.app.dynamic.v2.OfficialAccountInfoRitems
has_more (RhasMore
offset (Roffset"k
OfficialAccountsReq
	campus_id (RcampusId
campus_name (	R
campusName
offset (Roffset"?
OfficialDynamicsReply;
items (2%.bilibili.app.dynamic.v2.OfficialItemRitems
offset (Roffset
has_more (RhasMoreO
player_args (2..bilibili.app.archive.middleware.v1.PlayerArgsR
playerArgs"k
OfficialDynamicsReq
	campus_id (RcampusId
campus_name (	R
campusName
offset (Roffset"?
OfficialItem
type (RtypeQ
rcmd_archive (2,.bilibili.app.dynamic.v2.OfficialRcmdArchiveH RrcmdArchiveQ
rcmd_dynamic (2,.bilibili.app.dynamic.v2.OfficialRcmdDynamicH RrcmdDynamicB
	rcmd_item"?
OfficialRcmdArchive
title (	Rtitle
cover (	Rcover(
cover_right_text (	RcoverRightText

desc_icon1 (R	descIcon1

desc_text1 (	R	descText1

desc_icon2 (R	descIcon2

desc_text2 (	R	descText2
reason (	Rreason(
show_three_point	 (RshowThreePoint
uri
 (	Ruri
aid (Raid
mid (Rmid
name (	Rname

dynamic_id (R	dynamicId
cid (Rcid"?
OfficialRcmdDynamic
title (	Rtitle
cover (	Rcover/
cover_right_top_text (	RcoverRightTopText

desc_icon1 (R	descIcon1

desc_text1 (	R	descText1

desc_icon2 (R	descIcon2

desc_text2 (	R	descText2
reason (	Rreason
uri	 (	Ruri

dynamic_id
 (R	dynamicId
mid (Rmid
	user_name (	RuserName
rid (Rrid"S
OfficialVerify
type (Rtype
desc (	Rdesc
is_atten (RisAtten"R
	PGCSeason
	is_finish (RisFinish
title (	Rtitle
type (Rtype"
PlayurlParam
qn (Rqn
fnver (Rfnver
fnval (Rfnval

force_host (R	forceHost
fourk (Rfourk"C
Popup
title (	Rtitle
desc (	Rdesc
uri (	Ruri"?
RcmdArchive
title (	Rtitle
cover (	RcoverM
cover_left_icon_1 (2".bilibili.app.dynamic.v2.CoverIconRcoverLeftIcon1)
cover_left_text_1 (	RcoverLeftText1
uri (	Ruri
is_pgc (RisPgc
aid (Raid8
badge (2".bilibili.app.dynamic.v2.IconBadgeRbadge(
cover_left_icon2	 (RcoverLeftIcon2(
cover_left_text2
 (	RcoverLeftText2(
cover_left_icon3 (RcoverLeftIcon3(
cover_left_text3 (	RcoverLeftText3"?

RcmdAuthor9
author (2!.bilibili.app.dynamic.v2.UserInfoRauthor
desc (	Rdesc=
relation (2!.bilibili.app.dynamic.v2.RelationRrelation"?
RcmdItem5
type (2!.bilibili.app.dynamic.v2.RcmdTypeRtypeI
rcmd_archive (2$.bilibili.app.dynamic.v2.RcmdArchiveH RrcmdArchiveB
	rcmd_item"+

RcmdOption

show_title (R	showTitle"5
RcmdTopButton
text (	Rtext
url (	Rurl"-
RcmdUPsParam

dislike_ts (R	dislikeTs"?
Relation?
status (2'.bilibili.app.dynamic.v2.RelationStatusRstatus
	is_follow (RisFollow
is_followed (R
isFollowed
title (	Rtitle"?
RepostListReq

dynamic_id (	R	dynamicId
dyn_type (RdynType
rid (Rrid
offset (	Roffset
from (	RfromD
repost_type (2#.bilibili.app.dynamic.v2.RepostTypeR
repostType"?
RepostListRsp8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
offset (	Roffset
has_more (RhasMore
total_count (R
totalCountD
repost_type (2#.bilibili.app.dynamic.v2.RepostTypeR
repostType"Q
SchoolRecommendReply9
items (2#.bilibili.app.dynamic.v2.CampusInfoRitems"8
SchoolRecommendReq
lat (Rlat
lng (Rlng"?
SchoolSearchReply9
items (2#.bilibili.app.dynamic.v2.CampusInfoRitems:
toast (2$.bilibili.app.dynamic.v2.SearchToastRtoast"+
SchoolSearchReq
keyword (	Rkeyword"?
SearchChannel
title (	RtitleK
more_button (2*.bilibili.app.dynamic.v2.SearchTopicButtonR
moreButton@
channels (2$.bilibili.app.dynamic.v2.ChannelInfoRchannels"?

SearchInfo
title (	Rtitle8
list (2$.bilibili.app.dynamic.v2.DynamicItemRlist
track_id (	RtrackId
total (Rtotal
has_more (RhasMore
version (	Rversion"K
SearchToast

desc_text1 (	R	descText1

desc_text2 (	R	descText2"?
SearchTopic
title (	RtitleK
more_button (2*.bilibili.app.dynamic.v2.SearchTopicButtonR
moreButton>
items (2(.bilibili.app.dynamic.v2.SearchTopicItemRitems"D
SearchTopicButton
title (	Rtitle
jump_uri (	RjumpUri"?
SearchTopicItem
topic_id (RtopicId

topic_name (	R	topicName
desc (	Rdesc
url (	Rurl
is_activity (R
isActivity"(
SetDecisionReq
result (Rresult"R
SetRecentCampusReq
	campus_id (RcampusId
campus_name (	R
campusName"?
ShareChannel
name (	Rname
image (	Rimage
channel (	Rchannel?
reserve (2%.bilibili.app.dynamic.v2.ShareReserveRreserve"?
ShareReserve
title (	Rtitle
desc (	Rdesc 
qr_code_icon (	R
qrCodeIcon 
qr_code_text (	R
qrCodeText
qr_code_url (	R	qrCodeUrlF
	user_info (2).bilibili.app.dynamic.v2.AdditionUserInfoRuserInfo"M
SortType
	sort_type (RsortType$
sort_type_name (	RsortTypeName"?
StoryArchive
cover (	Rcover
aid (Raid
uri (	Ruri@
	dimension (2".bilibili.app.dynamic.v2.DimensionR	dimension"?
	StoryItem9
author (2!.bilibili.app.dynamic.v2.UserInfoRauthor
desc (	Rdesc
status (Rstatus
type (RtypeL
story_archive (2%.bilibili.app.dynamic.v2.StoryArchiveH RstoryArchiveB
	rcmd_item"R
SubscribeCampusReq
	campus_id (RcampusId
campus_name (	R
campusName"?
ThreePointAttention%
attention_icon (	RattentionIcon%
attention_text (	RattentionText,
not_attention_icon (	RnotAttentionIcon,
not_attention_text (	RnotAttentionTextJ
status (22.bilibili.app.dynamic.v2.ThreePointAttentionStatusRstatus"?
ThreePointAutoPlay
	open_icon (	RopenIcon
	open_text (	RopenText

close_icon (	R	closeIcon

close_text (	R	closeText 
open_text_v2 (	R
openTextV2"
close_text_v2 (	RcloseTextV2
	only_icon (	RonlyIcon
	only_text (	RonlyText 
open_icon_v2	 (	R
openIconV2"
close_icon_v2
 (	RcloseIconV2"?
ThreePointCommentI
up_selection (2&.bilibili.app.dynamic.v2.CommentDetailRupSelectionA
up_close (2&.bilibili.app.dynamic.v2.CommentDetailRupClose
icon (	Ricon
title (	Rtitle"?
ThreePointDefault
icon (	Ricon
title (	Rtitle
uri (	Ruri
id (	RidE
toast (2/.bilibili.app.dynamic.v2.ThreePointDefaultToastRtoast"B
ThreePointDefaultToast
title (	Rtitle
desc (	Rdesc"=
ThreePointDislike
icon (	Ricon
title (	Rtitle"?
ThreePointFavorite
icon (	Ricon
title (	Rtitle
id (Rid!
is_favourite (RisFavourite
cancel_icon (	R
cancelIcon!
cancel_title (	RcancelTitle"?
ThreePointHide
icon (	Ricon
title (	RtitleT
interactive (22.bilibili.app.dynamic.v2.ThreePointHideInteractiveRinteractive
	blook_fid (RblookFid

blook_type (	R	blookType"y
ThreePointHideInteractive
title (	Rtitle
confirm (	Rconfirm
cancel (	Rcancel
toast (	Rtoast"?
ThreePointItem;
type (2'.bilibili.app.dynamic.v2.ThreePointTypeRtypeF
default (2*.bilibili.app.dynamic.v2.ThreePointDefaultH RdefaultN
auto_player (2+.bilibili.app.dynamic.v2.ThreePointAutoPlayH R
autoPlayer@
share (2(.bilibili.app.dynamic.v2.ThreePointShareH RshareL
	attention (2,.bilibili.app.dynamic.v2.ThreePointAttentionH R	attention=
wait (2'.bilibili.app.dynamic.v2.ThreePointWaitH RwaitF
dislike (2*.bilibili.app.dynamic.v2.ThreePointDislikeH RdislikeI
favorite (2+.bilibili.app.dynamic.v2.ThreePointFavoriteH Rfavorite:
top	 (2&.bilibili.app.dynamic.v2.ThreePointTopH RtopF
comment
 (2*.bilibili.app.dynamic.v2.ThreePointCommentH Rcomment=
hide (2'.bilibili.app.dynamic.v2.ThreePointHideH Rhide_
topic_irrelevant (22.bilibili.app.dynamic.v2.ThreePointTopicIrrelevantH RtopicIrrelevantB
item"?
ThreePointShare
icon (	Ricon
title (	RtitleI
channel (2/.bilibili.app.dynamic.v2.ThreePointShareChannelRchannel!
channel_name (	RchannelName?
reserve (2%.bilibili.app.dynamic.v2.ShareReserveRreserve"B
ThreePointShareChannel
icon (	Ricon
title (	Rtitle"o
ThreePointTop
icon (	Ricon
title (	Rtitle4
type (2 .bilibili.app.dynamic.v2.TopTypeRtype"?
ThreePointTopicIrrelevant
icon (	Ricon
title (	Rtitle
toast (	Rtoast
topic_id (RtopicId
res_id (RresId
res_type (RresType
reason (	Rreason"?
ThreePointWait#
addition_icon (	RadditionIcon#
addition_text (	RadditionText(
no_addition_icon (	RnoAdditionIcon(
no_addition_text (	RnoAdditionText
id (Rid"_
TopAdditionUP3
up (2#.bilibili.app.dynamic.v2.AdditionUPRup
has_fold (RhasFold"k
TopicButton
icon (	Ricon
title (	Rtitle
jump_uri (	RjumpUri
red_dot (RredDot"?
	TopicItem
topic_id (RtopicId

topic_name (	R	topicName
url (	Rurl
desc (	Rdesc
desc2 (	Rdesc2
	rcmd_desc (	RrcmdDesc"?
	TopicList
title (	RtitleN
topic_list_item (2&.bilibili.app.dynamic.v2.TopicListItemRtopicListItemC

act_button (2$.bilibili.app.dynamic.v2.TopicButtonR	actButtonE
more_button (2$.bilibili.app.dynamic.v2.TopicButtonR
moreButton
server_info (	R
serverInfo"?
TopicListItem
icon (	Ricon

icon_title (	R	iconTitle
topic_id (RtopicId

topic_name (	R	topicName
url (	Rurl
pos (Rpos
server_info (	R
serverInfo"
head_icon_url (	RheadIconUrl
up_mid	 (RupMid"
tail_icon_url
 (	RtailIconUrl
	extension (	R	extension"}
TopicListReply8
items (2".bilibili.app.dynamic.v2.TopicItemRitems
has_more (RhasMore
offset (	Roffset"C
TopicListReq
	campus_id (RcampusId
offset (	Roffset"?
TopicRcmdCard
topic_id (RtopicId

topic_name (	R	topicName
url (	Rurl<
button (2$.bilibili.app.dynamic.v2.CampusLabelRbutton
desc1 (	Rdesc1
desc2 (	Rdesc2
update_desc (	R
updateDesc"?
TopicSquareInfo
title (	Rtitle<
button (2$.bilibili.app.dynamic.v2.CampusLabelRbutton:
rcmd (2&.bilibili.app.dynamic.v2.TopicRcmdCardRrcmd"P
TopicSquareReply<
info (2(.bilibili.app.dynamic.v2.TopicSquareInfoRinfo"-
TopicSquareReq
	campus_id (RcampusId"y
Unfollow
title (	Rtitle=
list (2).bilibili.app.dynamic.v2.UnfollowUserItemRlist
TrackId (	RTrackId"?
UnfollowUserItem

has_update (R	hasUpdate
face (	Rface
name (	Rname
uid (Ruid
pos (RposA

live_state (2".bilibili.app.dynamic.v2.LiveStateR	liveStateC
official (2'.bilibili.app.dynamic.v2.OfficialVerifyRofficial2
vip (2 .bilibili.app.dynamic.v2.VipInfoRvip
sign	 (	Rsign
label
 (	RlabelA
button (2).bilibili.app.dynamic.v2.AdditionalButtonRbutton
uri (	Ruri"?

UpListItem

has_update (R	hasUpdate
face (	Rface
name (	Rname
uid (Ruid
pos (RposK
user_item_type (2%.bilibili.app.dynamic.v2.UserItemTypeRuserItemTypeR
display_style_day (2&.bilibili.app.dynamic.v2.UserItemStyleRdisplayStyleDayV
display_style_night (2&.bilibili.app.dynamic.v2.UserItemStyleRdisplayStyleNight
style_id	 (RstyleIdA

live_state
 (2".bilibili.app.dynamic.v2.LiveStateR	liveState
	separator (R	separator
uri (	Ruri
	is_recall (RisRecall"9
UpListMoreLabel
title (	Rtitle
uri (	Ruri"?
UserInfo
mid (Rmid
name (	Rname
face (	RfaceC
official (2'.bilibili.app.dynamic.v2.OfficialVerifyRofficial2
vip (2 .bilibili.app.dynamic.v2.VipInfoRvip5
live (2!.bilibili.app.dynamic.v2.LiveInfoRlive
uri (	Ruri>
pendant (2$.bilibili.app.dynamic.v2.UserPendantRpendant@
	nameplate	 (2".bilibili.app.dynamic.v2.NameplateR	nameplate
level
 (Rlevel
sign (	Rsign
face_nft (RfaceNft 
face_nft_new (R
faceNftNew"?
UserItemStyle
	rect_text (	RrectText&
rect_text_color (	RrectTextColor
	rect_icon (	RrectIcon"
rect_bg_color (	RrectBgColor'
outer_animation (	RouterAnimation"a
UserPendant
pid (Rpid
name (	Rname
image (	Rimage
expire (Rexpire"?

VideoBadge
text (	Rtext

text_color (	R	textColor(
text_color_night (	RtextColorNight
bg_color (	RbgColor$
bg_color_night (	RbgColorNight!
border_color (	RborderColor,
border_color_night (	RborderColorNight
bg_style (RbgStyle
bg_alpha	 (RbgAlpha$
bg_alpha_night
 (RbgAlphaNight"?
VipInfo
Type (RType
status (Rstatus
due_date (RdueDate7
label (2!.bilibili.app.dynamic.v2.VipLabelRlabel

theme_type (R	themeType)
avatar_subscript (RavatarSubscript%
nickname_color (	RnicknameColor"S
VipLabel
path (	Rpath
text (	Rtext
label_theme (	R
labelTheme"m
Weight
title (	Rtitle9
items (2#.bilibili.app.dynamic.v2.WeightItemRitems
icon (	Ricon"?
WeightButton
jump_url (	RjumpUrl
title (	Rtitle"K
WeightDislike$
feed_back_type (	RfeedBackType
title (	Rtitle"?

WeightItem7
type (2#.bilibili.app.dynamic.v2.WeightTypeRtype?
button (2%.bilibili.app.dynamic.v2.WeightButtonH RbuttonB
dislike (2&.bilibili.app.dynamic.v2.WeightDislikeH RdislikeB
item*2
AddButtonBgStyle
fill 

stroke
gray*8
AddButtonType
bt_none 
bt_jump
	bt_button*n
AdditionVoteState
addition_vote_state_none 
addition_vote_state_open
addition_vote_state_close*?
AdditionVoteType
addition_vote_type_none 
addition_vote_type_word
addition_vote_type_pic
addition_vote_type_default*9
AdditionalButtonClickType

click_none 
click_up*:
AdditionalButtonStatus
none 
uncheck	
check*3
AdditionalShareShowType
st_none 
st_show*?
AdditionalType
additional_none 
additional_type_pgc
additional_type_goods
additional_type_vote
additional_type_common
additional_type_esport
additional_type_up_rcmd
additional_type_ugc"
additional_type_up_reservation*?
CampusTabType
campus_none 
campus_school
campus_dynamic
campus_account
campus_billboard
campus_topic*5
	CoverIcon
cover_icon_none 
cover_icon_play*?
DescType
desc_type_none 
desc_type_text
desc_type_aite
desc_type_lottery
desc_type_vote
desc_type_topic
desc_type_goods
desc_type_bv
desc_type_av
desc_type_emoji	
desc_type_user

desc_type_cv
desc_type_vc
desc_type_web
desc_type_taobao
desc_type_mail
desc_type_ogv_season
desc_type_ogv_ep
desc_type_search_word*'
DisableState
	highlight 
gary*?
DynExtendType
dyn_ext_type_none 
dyn_ext_type_topic
dyn_ext_type_lbs
dyn_ext_type_hot
dyn_ext_type_game
dyn_ext_type_common
dyn_ext_type_biliCut
dyn_ext_type_ogv
dyn_ext_type_auto_ogv*?
DynModuleType
module_none 
module_author
module_dispute
module_desc
module_dynamic
module_forward
module_likeUser
module_extend
module_additional
module_stat	
module_fold

module_comment
module_interaction
module_author_forward
	module_ad
module_banner
module_item_null
module_share_info
module_recommend
module_stat_forward

module_top
module_bottom
module_story
module_topic
module_topic_details_ext
module_top_tag
module_topic_brief
module_title*U

DynUriType
dyn_uri_type_none 
dyn_uri_type_direct
dyn_uri_type_suffix*?
DynamicType
dyn_none 
forward
av
pgc
courses
fold
word
draw
article	
music	
common_square

common_vertical
live
	medialist
courses_season
ad

applet
subscription
	live_rcmd

banner

ugc_season
subscription_new	
story

topic_rcmd*B
	EmojiType

emoji_none 
	emoji_old
	emoji_new
vip*
EspaceStyle
moba *m
FoldType
FoldTypeZore 
FoldTypePublish
FoldTypeFrequent
FoldTypeUnite
FoldTypeLimit*.

FollowType
ft_not_follow 
	ft_follow*9
HighlightTextStyle

style_none 
style_highlight*:

ImageStyle
add_style_vertical 
add_style_square*1
LightFromType

from_login 
from_unlogin*<
	LiveState
	live_none 
	live_live
live_rotation*<
LocalIconType
local_icon_comment 
local_icon_like*b
MdlDynCommonType
mdl_dyn_common_none 
mdl_dyn_common_square
mdl_dyn_common_vertica*?
MdlDynDrawTagType
mdl_draw_tag_none 
mdl_draw_tag_common
mdl_draw_tag_goods
mdl_draw_tag_user
mdl_draw_tag_topic
mdl_draw_tag_lbs*?
MdlDynSubscriptionNewStyle'
#mdl_dyn_subscription_new_style_nont '
#mdl_dyn_subscription_new_style_live'
#mdl_dyn_subscription_new_style_draw*g
	MediaType
MediaTypeNone 
MediaTypeUGC
MediaTypePGC
MediaTypeLive
MediaTypeVCS*?
ModuleAuthorBadgeType!
module_author_badge_type_none '
#module_author_badge_type_threePoint#
module_author_badge_type_button#
module_author_badge_type_weight*L
ModuleBannerType
module_banner_type_none 
module_banner_type_user*?
ModuleDynamicType
mdl_dyn_archive 
mdl_dyn_pgc
mdl_dyn_cour_season
mdl_dyn_cour_batch
mdl_dyn_forward
mdl_dyn_draw
mdl_dyn_article
mdl_dyn_music
mdl_dyn_common
mdl_dyn_live	
mdl_dyn_medialist

mdl_dyn_applet
mdl_dyn_subscription
mdl_dyn_live_rcmd
mdl_dyn_ugc_season
mdl_dyn_subscription_new*^
NetworkType

NT_UNKNOWN 
WIFI
CELLULAR
OFFLINE
OTHERNET
ETHERNET*.
RcmdType
rcmd_archive 
rcmd_dynamic*/
Refresh
refresh_new 
refresh_history*?
RelationStatus
relation_status_none 
relation_status_nofollow
relation_status_follow
relation_status_followed"
relation_status_mutual_concern
relation_status_special*0

RepostType

repost_hot 
repost_general*o
ReserveRelationLotteryType)
%reserve_relation_lottery_type_default &
"reserve_relation_lottery_type_cron*3
ReserveType
reserve_none 
reserve_recall*4
ShowType
show_type_none 
show_type_backup*L
	StyleType
STYLE_TYPE_NONE 
STYLE_TYPE_LIVE
STYLE_TYPE_DYN_UP*M
TFType

U_CARD 	
U_PKG

C_CARD	
C_PKG

T_CARD	
T_PKG*C
ThreePointAttentionStatus
tp_not_attention 
tp_attention*?
ThreePointType
tp_none 

background
	auto_play	
share
wait
	attention

report

delete
dislike
favorite	
top

comment
hide
campus_delete
topic_irrelevant*"
	ThumbType

cancel 	
thumb*'
TopType
top_none 

top_cancel*?
UserItemType
user_item_type_none 
user_item_type_live
user_item_type_live_custom
user_item_type_normal
user_item_type_extend*?
VideoSubType
VideoSubTypeNone 
VideoSubTypeBangumi
VideoSubTypeMovie
VideoSubTypeDocumentary
VideoSubTypeDomestic
VideoSubTypeTeleplay*j
	VideoType
video_type_general 
video_type_dynamic
video_type_playback
video_type_story*'

VoteStatus

normal 
	anonymous*B

WeightType
weight_none 
weight_dislike
weight_jump2?!
DynamicX
DynVideo$.bilibili.app.dynamic.v2.DynVideoReq&.bilibili.app.dynamic.v2.DynVideoReplyR
DynAll".bilibili.app.dynamic.v2.DynAllReq$.bilibili.app.dynamic.v2.DynAllReply^

DynDetails&.bilibili.app.dynamic.v2.DynDetailsReq(.bilibili.app.dynamic.v2.DynDetailsReplyp
DynVideoPersonal,.bilibili.app.dynamic.v2.DynVideoPersonalReq..bilibili.app.dynamic.v2.DynVideoPersonalReplyd
DynVideoUpdOffset-.bilibili.app.dynamic.v2.DynVideoUpdOffsetReq .bilibili.app.dynamic.v2.NoReply?
DynAdditionCommonFollow3.bilibili.app.dynamic.v2.DynAdditionCommonFollowReq5.bilibili.app.dynamic.v2.DynAdditionCommonFollowReplyR
DynThumb$.bilibili.app.dynamic.v2.DynThumbReq .bilibili.app.dynamic.v2.NoReplya
DynFakeCard'.bilibili.app.dynamic.v2.DynFakeCardReq).bilibili.app.dynamic.v2.DynFakeCardReplys
DynRcmdUpExchange-.bilibili.app.dynamic.v2.DynRcmdUpExchangeReq/.bilibili.app.dynamic.v2.DynRcmdUpExchangeReplyj
DynAllPersonal*.bilibili.app.dynamic.v2.DynAllPersonalReq,.bilibili.app.dynamic.v2.DynAllPersonalReply`
DynAllUpdOffset+.bilibili.app.dynamic.v2.DynAllUpdOffsetReq .bilibili.app.dynamic.v2.NoReplyU
DynVote#.bilibili.app.dynamic.v2.DynVoteReq%.bilibili.app.dynamic.v2.DynVoteReply|
DynMixUpListViewMore0.bilibili.app.dynamic.v2.DynMixUpListViewMoreReq2.bilibili.app.dynamic.v2.DynMixUpListViewMoreReplyX
DynLight$.bilibili.app.dynamic.v2.DynLightReq&.bilibili.app.dynamic.v2.DynLightReply[
	DynDetail%.bilibili.app.dynamic.v2.DynDetailReq'.bilibili.app.dynamic.v2.DynDetailReplyX
LikeList$.bilibili.app.dynamic.v2.LikeListReq&.bilibili.app.dynamic.v2.LikeListReply\

RepostList&.bilibili.app.dynamic.v2.RepostListReq&.bilibili.app.dynamic.v2.RepostListRspV
DynSpace$.bilibili.app.dynamic.v2.DynSpaceReq$.bilibili.app.dynamic.v2.DynSpaceRsp\
DynUnLoginRcmd#.bilibili.app.dynamic.v2.DynRcmdReq%.bilibili.app.dynamic.v2.DynRcmdReplyp
DynServerDetails,.bilibili.app.dynamic.v2.DynServerDetailsReq..bilibili.app.dynamic.v2.DynServerDetailsReply[
	DynSearch%.bilibili.app.dynamic.v2.DynSearchReq'.bilibili.app.dynamic.v2.DynSearchReplyX
SetDecision'.bilibili.app.dynamic.v2.SetDecisionReq .bilibili.app.dynamic.v2.NoReplyj
AlumniDynamics*.bilibili.app.dynamic.v2.AlumniDynamicsReq,.bilibili.app.dynamic.v2.AlumniDynamicsReply^

CampusRcmd&.bilibili.app.dynamic.v2.CampusRcmdReq(.bilibili.app.dynamic.v2.CampusRcmdReply`
SubscribeCampus+.bilibili.app.dynamic.v2.SubscribeCampusReq .bilibili.app.dynamic.v2.NoReply`
SetRecentCampus+.bilibili.app.dynamic.v2.SetRecentCampusReq .bilibili.app.dynamic.v2.NoReplyR
DynTab".bilibili.app.dynamic.v2.DynTabReq$.bilibili.app.dynamic.v2.DynTabReplyd
SchoolSearch(.bilibili.app.dynamic.v2.SchoolSearchReq*.bilibili.app.dynamic.v2.SchoolSearchReplym
SchoolRecommend+.bilibili.app.dynamic.v2.SchoolRecommendReq-.bilibili.app.dynamic.v2.SchoolRecommendReply
DynSpaceSearchDetails1.bilibili.app.dynamic.v2.DynSpaceSearchDetailsReq3.bilibili.app.dynamic.v2.DynSpaceSearchDetailsReplyp
OfficialAccounts,.bilibili.app.dynamic.v2.OfficialAccountsReq..bilibili.app.dynamic.v2.OfficialAccountsReplyp
OfficialDynamics,.bilibili.app.dynamic.v2.OfficialDynamicsReq..bilibili.app.dynamic.v2.OfficialDynamicsReplyd
CampusRedDot(.bilibili.app.dynamic.v2.CampusRedDotReq*.bilibili.app.dynamic.v2.CampusRedDotReplyj
CampusRcmdFeed*.bilibili.app.dynamic.v2.CampusRcmdFeedReq,.bilibili.app.dynamic.v2.CampusRcmdFeedReplya
TopicSquare'.bilibili.app.dynamic.v2.TopicSquareReq).bilibili.app.dynamic.v2.TopicSquareReply[
	TopicList%.bilibili.app.dynamic.v2.TopicListReq'.bilibili.app.dynamic.v2.TopicListReplyv
CampusMateLikeList..bilibili.app.dynamic.v2.CampusMateLikeListReq0.bilibili.app.dynamic.v2.CampusMateLikeListReplyj
CampusFeedback*.bilibili.app.dynamic.v2.CampusFeedbackReq,.bilibili.app.dynamic.v2.CampusFeedbackReplym
CampusBillboard+.bilibili.app.dynamic.v2.CampusBillBoardReq-.bilibili.app.dynamic.v2.CampusBillBoardReply}
CampusBillboardInternal3.bilibili.app.dynamic.v2.CampusBillboardInternalReq-.bilibili.app.dynamic.v2.CampusBillBoardReplyy
CampusTopicRcmdFeed/.bilibili.app.dynamic.v2.CampusTopicRcmdFeedReq1.bilibili.app.dynamic.v2.CampusTopicRcmdFeedReplyJ??
  ?"

  

  
	
  #
	
 :

  [
 v2动态



 

  
6 动态视频页


  


  


  
'4

 0 动态综合页


 

 

 #.
/
 <" 批量动态id获取动态详情


 

  

 +:
4
 N' 视频页最近访问 - 个人feed流


 

 ,

 7L
3
 B& 视频页最近访问 - 标记已读


 

 .

 9@
8
 b+ 动态通用附加卡-follow/取消follow


 

  :

 D`

 / 动态点赞


 

 

 &-
*
 > 动态发布生成临时卡


 

 "

 ,<
)
 P 关注推荐up主换一换


 

 .

 8N
4
 	H' 综合页最近访问 - 个人feed流


 	

 	(

 	3F
3
 
>& 综合页最近访问 - 标记已读


 


 
*

 
5<
!
  3 投票操作接口


  

  

  %1
1
 "Z$ 网关调用 - 查看更多-列表


 "

 "4

 "?X

 $6 轻浏览


 $

 $

 $'4

 &9 动态详情页


 &

 &

 &)7

 (6 点赞列表


 (

 (

 ('4

 *: 转发列表


 *

 * 

 *+8

 ,4 空间页动态


 ,

 ,

 ,'2
,
 .: 未登录页分区UP主推荐


 .

 .!

 .,8

 0O


 0

 0-

 08M

 29


 2

 2

 2)7

 46


 4

 4"

 4-4

 6H


 6

 6(

 63F

 8<


 8

 8 

 8+:

 :>


 :

 :*

 :5<

 <>


 <

 <*

 <5<

 >0


 >

 >

 >#.

 @B


 @

 @$

 @/@

 BK


 B

 B*

 B5I

 D]


 D

 D6

 DA[

 FN


 F

 F,

 F7L

 HN


 H

 H,

 H7L

  JB


  J

  J$

  J/@

 !LH


 !L

 !L(

 !L3F

 "N?


 "N

 "N"

 "N-=

 #P9


 #P

 #P

 #P)7

 $RT


 $R

 $R0

 $R;R

 %TH


 %T

 %T(

 %T3F

 &VK


 &V

 &V*

 &V5I

 'X[


 'X

 'X :

 'XEY

 (ZW


 (Z

 (Z2

 (Z=U
K
 ^ c? 综合页请求广告所需字段，由客户端-网关透传



 ^
L
  `? 综合页请求广告所需字段，由客户端-网关透传


  `


  `

  `

 b request_id


 b


 b

 b

 f j



 f

  g" 默认填充


  g

  g

 h" 描边


 h


 h

 i" 置灰


 i

 i

m q 按钮类型



m

 n" 占位


 n

 n

o" 跳转


o

o

p" 按钮


p

p
)
t ? 动态-附加卡-通用卡



t
!
 v 头部说明文案


 v


 v

 v

x 标题


x


x

x

z 展示图


z


z

z

| 描述文字1


|


|

|

~ 描述文字2


~


~

~
"
? 点击跳转链接


?


?

?

?  按钮


?

?

?

? 头部icon


?


?

?

? style


?

?

?
*
	? 动态本身的类型 type


	?


	?

	?
,

? 附加卡类型
" ogv manga



?



?


?
*
? ? 动态-附加卡-电竞卡


?

 ? 电竞类型


 ?

 ?

 ?

 ??

 ?


?4	 moba类


?

?/

?23
*
? 动态本身的类型 type


?


?

?
,
? 附加卡类型
" ogv manga


?


?

?
2
? ?$ 动态-附加卡-电竞卡-moba类


?
"
 ? 头部说明文案


 ?


 ?

 ?

? 标题


?


?

?

?& 战队列表


?

?

?!

?$%

?= 比赛信息


?

?8

?;<

? 卡片跳转


?


?

?

?  按钮


?

?

?

? 副标题


?


?

?
*
? 动态本身的类型 type


?


?

?

? 附加卡类型


?


?

?

	? 附加卡图标


	?


	?

	?
?
? ?1 动态-附加卡-电竞卡-moba类-比赛信息


? 

 ?O 文案类


 ?

 ?)

 ?*J

 ?MN
"
? 比赛状态文案


?


?

?
"
? 比赛状态状态


?	

?


?

? 日间色值


?


?

?

? 夜间色值


?


?

?
I
? ?; 动态-附加卡-电竞卡-moba类-比赛信息-文案类


?$

 ? 文案


 ?


 ?

 ?

? 日间色值


?


?

?

? 夜间色值


?


?

?
*
? ? 动态-附加卡-商品卡


?

 ? 推荐文案


 ?


 ?

 ?

?' 商品信息


?

?

?"

?%&

? 附加卡类型


?


?

?

? 头部icon


?


?

?
+
? 商品附加卡整卡跳转


?


?

?
u
?g 商品类型
 1:淘宝 2:会员购，注：实际是获取的goods_items里面的第一个source_type


?	

?


?
$
? ? up主预约发布卡


?

 ? 标题


 ?


 ?

 ?
,
?" 高亮文本，描述文字1


?

?

? !

? 描述文字2


?


?

?
"
? 点击跳转链接


?


?

?

?  按钮


?

?

?

? 附加卡类型


?


?

?
6
?( 预约人数(用于预约人数变化)


?	

?


?

?# 活动皮肤


?

?

?!"

?
 预约id


?	

?


?

	?


	?	

	?


	?


?"



?


?


?!

?


?	

?


?

?$


?

?

?!#

?


?


?

?

?


?

?	

?

?


?	

?


?

?


?


?

?
3
? ?% 动态-附加卡-UGC视频附加卡


?

 ? 说明文案


 ?


 ?

 ?

? 稿件标题


?


?

?

? 封面


?


?

?

? 描述文字1


?


?

?

? 描述文字2


?


?

?

? 接秒开


?


?

?

? 时长


?


?

?
?
?{ 标题支持换行-标题支持单行和双行，本期不支持填充up昵称，支持双行展示，字段默认为true


?

?	

?

? 附加卡类型


?


?

?

	? ?


	?

	 ?


	 ?


	 ?

	 ?

	?


	?


	?

	?
'

? ? 动态-附加卡-投票



?


 ? 封面图



 ?



 ?


 ?


? 标题



?



?


?


? 展示项1



?



?


?


? button文案



?



?


?
"

? 点击跳转链接



?



?


?
#
? ? 动态模块-投票


?

 ?, 投票类型


 ?

 ?'

 ?*+

?
 投票ID


?	

?


?

? 标题


?


?

?
?
?? 已过期： xxx人参与· 投票已过期。button 展示去查看
 未过期： xxx人参与· 剩xx天xx时xx分。button展示去投票


?


?

?

? 剩余时间


?	

?


?

? 生效文案


?


?

?

? 过期文案


?


?

?

? 已投票


?


?

?

?  投票状态


?

?

?

 ?? 投票信息


 ?


	?1


	?

	?+

	?.0


?/



?


?)


?,.

?7


?

?1

?46
=
?/ 业务类型
 0:动态投票 1:话题h5组件


?	

?


?

? 投票总人数


?	

?


?

? 附加卡类型


?


?

?

? 异常提示


?


?

?

? 跳转地址


?


?

?

? 是否投票


?

?	

?
5
?' 投票最多多选个数，单选为1


?	

?


?
1
?## 是否默认选中分享到动态


?

?	

? "

? ? 外露投票


?

 ? 图片 多张


 ?

 ?

 ?

 ?
"
? ? 外露图片类型


?
"
 ?* 图片投票详情


 ?

 ? 

 ?!%

 ?()
"
? ? 图片投票详情


?
)
 ? 选项索引，从1开始


 ?	

 ?


 ?

? 图片


?


?

?

? 选中状态


?

?	

?

? 人数


?	

?


?

? 占比


?


?

?

? 标题文案


?


?

?
1
?# 是否投票人数最多的选项


?

?


?

? ? 投票状态


?

 ?!"


 ?

 ? 

?!"


?

? 

?""


?

? !

? ? 投票类型


?

 ? "


 ?

 ?

? "


?

?

?"


?

?

?#"


?

?!"
"
? ? 外露文字类型


?
(
 ?+ 外露文字投票详情


 ?

 ?!

 ?"&

 ?)*
(
? ? 外露文字投票详情


?
)
 ? 选项索引，从1开始


 ?	

 ?


 ?

? 文案


?


?

?

? 选中状态


?

?	

?

? 人数


?	

?


?

? 占比


?


?

?
1
?# 是否投票人数最多的选项


?

?


?

? ? 活动皮肤


?
 
 ? 动画SVGA资源


 ?


 ?

 ?
2
?$ 动画SVGA最后一帧图片资源


?


?

?
"
? 动画播放次数


?	

?


?
'
? ? 动态-附加卡-按钮


?

 ? 按钮类型


 ?

 ?

 ?
!
?) jump-跳转样式


?

?$

?'(
!
? jump-跳转链接


?


?

?
#
?& button-未点样式


?

?!

?$%
#
?$ button-已点样式


?

?

?"#
#
?& button-当前状态


?

?!

?$%
"
?- 按钮点击样式


?

?(

?+,
+
? ? 附加卡按钮点击类型


?

 ?" 通用按钮


 ?

 ?

?" 预约卡按钮


?

?

? ?


?#

 ? 是否弹窗


 ?


 ?

 ?
"
? 弹窗确认文案


?


?

?
"
? 弹窗取消文案


?


?

?

?


?


?

?

? ?


?

 ?


 ?	

 ?


 ?

?


?


?

?

?


?


?

?
%
? ? 附加卡按钮状态


?

 ?"


 ?

 ?

?"


?

?

?"


?	

?
-
? ? 动态-附加卡-按钮样式


?

 ? icon


 ?


 ?

 ?

? 文案


?


?

?
"
?0 按钮点击交互


?

? +

?./
(
?" 当前按钮填充样式


?

?

? !
2
?$ toast文案, 当disable=1时有效


?


?

?
J
?< 当前按钮样式,
 0:高亮 1:置灰(按钮不可点击)


?

?

?

?$


?

?

?"#
*
? ? 动态-附加卡-番剧卡


?
"
 ? 头部说明文案


 ?


 ?

 ?

? 标题


?


?

?

? 展示图


?


?

?

? 描述文字1


?


?

?

? 描述文字2


?


?

?
"
? 点击跳转链接


?


?

?

?  按钮


?

?

?

? 头部icon


?


?

?

? style


?

?

?
*
	? 动态本身的类型 type


	?


	?

	?

? ?


?

 ?"


 ?

 ?

?"


?

?
&
? ? 枚举-动态附加卡


?

 ?" 占位


 ?

 ?
 
?" 附加卡-追番


?

?
 
?" 附加卡-商品


?

?

?" 附加卡投票


?

?

?" 附加通用卡


?

?

?" 附加电竞卡


?

?
$
? " 附加UP主推荐卡


?

?

?" 附加卡-ugc


?

?

?'" UP主预约卡


?"

?%&

? ?


?

 ?"


 ?

 ?

 ?

 ? !

?


?


?

?

? ?


?

 ?


 ?	

 ?


 ?

?


?	

?


?

?B


?1

?2=

?@A

?


?	

?


?

?


?	

?


?

? ?


?

 ?


 ?


 ?

 ?

?


?


?

?

? ?


?

 ?


 ?


 ?

 ?

?


?


?

?

?


?


?

?

?


?	

?


?

?


?


?

?

?#


?

?

?

?!"

?


?


?

?

?


?	

?


?

?


?


?

?

	?


	?	

	?


	?

? ?


?

 ?


 ?	

 ?


 ?

?


?


?

?

?B


?1

?2=

?@A

? ?


?"

 ?


 ?	

 ?


 ?

?


?	

?


?

?


?


?

?

? ?


?

 ?


 ?	

 ?


 ?

?


?	

?


?

?


?	

?


?

?


?


?

?

? ?


?

 ?


 ?


 ?

 ?

? ?


?

 ?*


 ?

 ?

 ? %

 ?()

?


?	

?


?

 ? ?


 ?

  ?


  ?	

  ?


  ?

 ?


 ?


 ?

 ?

 ?


 ?


 ?

 ?

 ?


 ?	

 ?


 ?

!? ?


!?

! ?


! ?


! ?

! ?

!?


!?


!?

!?

!?


!?


!?

!?

"? ?


"?

" ?#


" ?

" ?

" ?

" ?!"

#? ?


#?

# ?


# ?	

# ?


# ?

$? ?


$?

$ ?


$ ?


$ ?

$ ?

$?


$?


$?

$?

$?


$?

$?

$?

%? ?


%?

% ?"


% ?

% ?

% ?

% ? !

%?


%?


%?

%?

%?


%?

%?

%?

%?


%?

%?	

%?

%?


%?

%?	

%?

&? ?


&?

& ?


& ?	

& ?


& ?

&?


&?	

&?


&?

&?B


&?1

&?2=

&?@A

&?


&?	

&?


&?

&?


&?	

&?


&?

&?


&?	

&?


&?

&?


&?


&?

&?

'? ?


'?

' ?


' ?


' ?

' ?

'?&


'?

'?

'?!

'?$%

(? ?


(?

( ?


( ?


( ?

( ?

(? 


(?

(?

(?

(?

(?


(?	

(?


(?

(? 


(?

(?

(?

)? ?


)?

) ?


) ?

) ?

) ?

)?


)?

)?

)?

)?


)?

)?

)?

)?


)?	

)?


)?

*? ?


*?

* ?


* ?	

* ?


* ?

*?


*?


*?

*?

*?


*?


*?

*?

*?


*?


*?

*?

*?B


*?1

*?2=

*?@A

+? ?


+?

+ ?


+ ?	

+ ?


+ ?

+?


+?


+?

+?

+?


+?


+?

+?

+?


+?


+?

+?

+?


+?	

+?


+?

+?


+?

+?

+?

+?!


+?

+?

+? 

+?!


+?

+?

+? 

+?


+?


+?

+?

+	?


+	?


+	?

+	?

+
?"


+
?

+
?

+
?!

+?#


+?

+?

+? "

+?


+?	

+?


+?

,? ?


,?

, ?


, ?	

, ?


, ?

-? ?


-?

- ?


- ?	

- ?


- ?

.? ?


.?

. ?


. ?


. ?

. ?

.?


.?


.?

.?

.?


.?	

.?


.?

.?


.?	

.?


.?

? ?


?

 ?"


 ?

 ?

?"


?

?

?"


?

?

?"


?

?

?"


?

?

?"


?

?

/? ?


/?

/ ?


/ ?	

/ ?


/ ?

/?


/?


/?

/?

/?(


/?

/?

/?#

/?&'

/?!


/?

/?

/? 

/?


/?


/?

/?

/?)


/?

/?

/?$

/?'(

/?!


/?

/?

/? 

/? 


/?

/?

/?

/?%


/?

/? 

/?#$

/	?


/	?


/	?

/	?

/
?"


/
?


/
?

/
?!

0? ?


0? 

0 ?"


0 ?

0 ?

0 ?

0 ? !

0?


0?


0?

0?

0?


0?

0?	

0?

0?


0?


0?

0?

1? ?


1?

1 ?


1 ?	

1 ?


1 ?

1?


1?


1?

1?

1?B


1?1

1?2=

1?@A

1?


1?	

1?


1?
"
2? ? 动态卡片列表


2?

2 ?" 动态列表


2 ?

2 ?

2 ?

2 ? !
"
2? 更新的动态数


2?	

2?


2?

2? 历史偏移


2?


2?

2?
"
2? 更新基础信息


2?


2?

2?
(
2? 是否还有更多数据


2?

2?	

2?
&
3? ? 视频页-我的追番


3?
*
3 ? 查看全部(跳转链接)


3 ?


3 ?

3 ?

3?% 追番列表


3?

3?

3? 

3?#$
&
4? ? 视频页-最近访问


4?
"
4 ? 标题展示文案


4 ?


4 ?

4 ?

4?! up主列表


4?

4?

4?

4? 
4
4?& 服务端生成的透传上报字段


4?


4?

4?

4? 直播数


4?	

4?


4?

4?# 跳转label


4?

4?

4?!"
'
4? 标题开关(综合页)


4?	

4?


4?
6
4?( 是否展示右上角查看更多label


4?

4?	

4?
:
4?, 是否在快速消费页查看更多按钮


4?

4?	

4?
4
4?& 是否展示右侧查看更多按钮


4?

4?	

4?

5? ?


5?

5 ?


5 ?	

5 ?


5 ?

5?


5?


5?

5?

5?


5?


5?

5?

5?


5?

5?	

5?

5?


5?


5?

5?

5? 


5?

5?

5?

5?

5?


5?


5?

5?

5?


5?


5?

5?
%
6? ? 评论外露展示项


6?

6 ? 用户mid


6 ?	

6 ?


6 ?

6? 用户昵称


6?


6?

6?
"
6? 点击跳转链接


6?


6?

6?

6? 评论内容


6?


6?

6?

7? ? 精选评论区


7?
%
7 ? 该功能能不能用


7 ?

7 ?	

7 ?
?
7?z up关闭评论区功能 1允许关闭 0允许开放
 精选评论区功能 1允许停止评论精选 0允许评论精选


7?	

7?


7?

	? ?


	?
&
	 ?" 占位 啥都不展示


	 ?

	 ?

	?" 播放icon


	?

	?
/
8? ?! 装扮卡片-粉丝勋章信息


8?

8 ? 是否是粉丝


8 ?	

8 ?


8 ?

8? 数量


8?	

8?


8?

8? 数量 str


8?


8?

8?

8? 颜色


8?


8?

8?

9? ? 装扮卡片


9?

9 ? 装扮卡片id


9 ?	

9 ?


9 ?
"
9? 装扮卡片链接


9?


9?

9?
.
9?  装扮卡片点击跳转链接


9?


9?

9?

9? 粉丝样式


9?

9?

9?


? ? 文本类型



?


 ?" 占位



 ?


 ?


?" 文本



?


?


?" @



?


?


?" 抽奖



?


?


?" 投票



?


?


?" 话题



?


?


?" 商品



?


?


?" bv



?


?


?" av



?


?


	?" 表情



	?


	?



?" 外露用户




?



?


?" 专栏



?


?


?" 小视频



?


?


?" 网址



?


?


?" 淘宝



?


?


?" 邮箱



?


?


?" 番剧season



?


?


?"
 番剧ep



?


?


?"



?


?

:? ? 文本描述


:?

: ? 文本内容


: ?


: ?

: ?

:? 文本类型


:?

:?

:?
"
:? 点击跳转链接


:?


:?

:?

:? emoji类型


:?

:?

:?

:? 商品类型


:?


:?

:?

:? 前置Icon


:?


:?

:?

:? icon_name


:?


:?

:?

:?
 资源ID


:?


:?

:?
%
:? 商品卡特殊字段


:?

:?

:?
"
:	? 文本原始文案


:	?


:	?

:	?

:
?


:
?	

:
?


:
?

;? ? 尺寸信息


;?

; ?


; ?	

; ?


; ?

;?


;?	

;?


;?

;?


;?	

;?


;?

? ?


?

 ?" 高亮


 ?

 ?
*
?" 置灰(按钮不可点击)


?

?
@
<? ?2 动态通用附加卡-follow/取消follow-响应


<?$

< ?&


< ?

< ?!

< ?$%
@
=? ?2 动态通用附加卡-follow/取消follow-请求


=?"

= ?&


= ?

= ?!

= ?$%

=?


=?


=?

=?

=?


=?


=?

=?
7
>? ?) 最近访问-个人feed流列表-返回


>?

> ?" 动态列表


> ?

> ?

> ?

> ? !

>? 偏移量


>?


>?

>?
(
>? 是否还有更多数据


>?

>?	

>?

>? 已读进度


>?


>?

>?

>? 关注状态


>?

>?

>?

>?" 顶部预约卡


>?

>?

>? !
7
?? ?) 最近访问-个人feed流列表-请求


??
#
? ? 被访问者的 UID


? ?	

? ?


? ?
,
?? 偏移量 第一页可传空


??


??

??
"
?? 标明下拉几次


??	

??


??
?
??? 是否是预加载 默认是1；客户端预加载。1：是预加载，不更新已读进度，不会影响小红点；0：非预加载，更新已读进度


??	

??


??
F
??#8 秒开参数 新版本废弃，统一使用player_args


??

??

??!"
\
??N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


??	

??


??
4
??& 服务端生成的透传上报字段


??


??

??

?? 来源


??


??

??

??B 秒开用


??1

??2=

??@A
&
@? ? 动态综合页-响应


@?

@ ?! 卡片列表


@ ?

@ ?

@ ? 

@?  顶部up list


@?

@?

@?

@? 话题广场


@?

@?

@?

@? 无关注推荐


@?

@?

@?

@?" 分区UP推荐


@?

@?

@? !
&
A? ?	 动态综合页-请求


A?
&
A ? 透传 update_baseline


A ?


A ?

A ?
%
A? 透传 history_offset


A?


A?

A?

A? 向下翻页数


A?	

A?


A?
8
A?* 刷新方式 1向上刷新 2向下翻页


A?

A?

A?
F
A?#8 秒开参数 新版本废弃，统一使用player_args


A?

A?

A?!"
1
A?# 综合页当前更新的最大值


A?


A?

A?
\
A?N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


A?	

A?


A?
2
A?$$ 推荐up主入参(new的时候传)


A?

A?

A?"#

A? 广告参数


A?

A?

A?

A	? 是否冷启


A	?	

A	?


A	?

A
? 来源


A
?


A
?

A
?

A?	C 秒开参数


A?	1

A?	2=

A?	@B

A?	


A?		

A?	


A?	

A?	


A?		

A?	


A?	
0
B?	 ?	" 最近访问-标记已读-请求


B?	
"
B ?	 被访问者的UID


B ?		

B ?	


B ?	
"
B?	 用户已读进度


B?	


B?	

B?	
4
B?	& 服务端生成的透传上报字段


B?	


B?	

B?	
&
C?	 ?	 动态详情页-响应


C?	

C ?	 动态详情


C ?	

C ?	

C ?	
&
D?	 ?	 动态详情页-请求


D?	

D ?	
 up主uid


D ?		

D ?	


D ?	

D?	
 动态ID


D?	


D?	

D?	

D?	 动态类型


D?		

D?	


D?	
!
D?	 业务方资源id


D?		

D?	


D?	

D?	 广告参数


D?	

D?	

D?	

D?	 From来源


D?	


D?	

D?	

D?	B 秒开参数


D?	1

D?	2=

D?	@A

D?	
 分享id


D?	


D?	

D?	
J
D?	< 分享类型
 1:文字 2:图片 3:链接 4:视频 5:音频


D?		

D?	


D?	
\
D	?	N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


D	?		

D	?	


D	?	

D
?		 pattern


D
?	


D
?	

D
?	
7
E?	 ?	) 批量动态id获取动态详情-响应


E?	

E ?	" 动态列表


E ?	

E ?	

E ?	

E ?	 !
7
F?	 ?	) 批量动态id获取动态详情-请求


F?	

F ?	
 动态id


F ?	


F ?	

F ?	
F
F?	#8 秒开参数 新版本废弃，统一使用player_args


F?	

F?	

F?	!"
\
F?	N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


F?		

F?	


F?	

F?	B 秒开参数


F?	1

F?	2=

F?	@A
"
?	 ?	 动态小卡类型


?	

 ?	" 占位


 ?	

 ?	

?	" 话题小卡


?	

?	

?	" lbs小卡


?	

?	

?	" 热门小卡


?	

?	

?	" 游戏小卡


?	

?	

?	" 通用小卡


?	

?	

?	" 必剪小卡


?	

?	

?	" ogv小卡


?	

?	
%
?	" 自动附加ogv小卡


?	

?	
2
G?	 ?	$ 动态发布生成临时卡-响应


G?	

G ?	 动态卡片


G ?	

G ?	

G ?	
2
H?	 ?	$ 动态发布生成临时卡-请求


H?	
&
H ?	卡片内容json string


H ?	


H ?	

H ?	
 
I?	 ?	 轻浏览-响应


I?	

I ?	! 卡片列表


I ?	

I ?	

I ?	 
 
J?	 ?	 轻浏览-请求


J?	
%
J ?	 透传 history_offset


J ?	


J ?	

J ?	

J?	 向下翻页数


J?		

J?	


J?	

J?	 来源


J?	


J?	

J?	

J?	B 秒开参数


J?	1

J?	2=

J?	@A
\
J?	N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


J?		

J?	


J?	

J?	


J?		

J?	


J?	

J?	


J?		

J?	


J?	
*
K?	 ?
 查看更多-列表-响应


K?	!

K ?	%


K ?	

K ?	

K ?	 

K ?	#$

K?	$


K?	


K?	

K?	"#
"
K?	& 排序类型列表


K?	

K?	

K?	!

K?	$%
1
K?	"# 是否展示更多的排序策略


K?	

K?		

K?	 !
"
K?
! 默认排序策略


K?
	

K?



K?
 
#
L?
 ?
 查看更多-请求


L?

e
L ?
W 排序策略
 1:推荐排序 2:最常访问 3:最近关注，其他值为默认排序


L ?
	

L ?



L ?

"
?
 ?
 动态模块类型


?


 ?
" 占位


 ?


 ?


?
" 发布人模块


?


?


?
" 争议小黄条


?


?


?
" 描述文案


?


?


?
" 动态卡片


?


?


?
" 转发模块


?


?

$
?
" 点赞用户(废弃)


?


?


?
" 小卡模块


?


?


?
" 附加卡


?


?


	?
" 计数信息


	?


	?



?
" 折叠



?



?

$
?
" 评论外露(废弃)


?


?

3
?
"% 外露交互模块(点赞、评论)


?


?

+
?
" 转发卡的发布人模块


?


?


?
" 广告卡模块


?


?


?
" 通栏模块


?


?

(
?
" 获取物料失败模块


?


?


?
" 分享组件


?


?

"
?
" 相关推荐模块


?


?

%
?
" 转发卡计数信息


?


?


?
" 顶部模块


?


?


?
" 底部模块


?


?


?
"


?


?


?
"


?


?


?
""


?


?
!

?
"


?


?


?
"


?


?


?
"


?


?

 
M?
 ?
 推荐页-响应


M?

%
M ?
" 推荐页返回参数


M ?


M ?


M ?
 !

M?
!


M?


M?


M?
 
 
N?
 ?
 推荐页-请求


N?


N ?
B 秒开参数


N ?
1

N ?
2=

N ?
@A
\
N?
N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


N?
	

N?



N?


N?



N?
	

N?



N?


N?



N?


N?
	

N?

1
O?
 ?
# 关注推荐up主换一换-响应


O?


O ?
 无关注推荐


O ?


O ?


O ?

1
P?
 ?
# 关注推荐up主换一换-请求


P?


P ?
 登录用户id


P ?
	

P ?



P ?

T
P?
F 上一次不感兴趣的ts，单位：秒；该字段透传给搜索


P?
	

P?



P?

F
P?
8 需要与服务端确认或参照客户端现有参数


P?



P?


P?

%
Q?
 ?
 推荐页返回参数


Q?

(
Q ?
) 分区推荐项目列表


Q ?


Q ?


Q ?
$

Q ?
'(
(
Q?
 分区聚类推荐选项


Q?


Q?


Q?

"
R?
 ?
 分区推荐项目


R?


R ?

 分区id


R ?
	

R ?



R ?


R?
 标题


R?



R?


R?


R?
" 推荐模块


R?


R?


R?


R?
 !

S?
 ?



S?


S ?
#


S ?


S ?


S ?
!"

S?
!


S?


S?


S?
 

S?



S?


S?


S?


T?
 ?



T?


T ?



T ?



T ?


T ?


T?



T?
	

T?



T?


T?



T?
	

T?



T?


T?
B


T?
1

T?
2=

T?
@A

U?
 ?



U?


U ?
&


U ?


U ?
!

U ?
$%

V?
 ?


V?


V ?



V ?
	

V ?



V ?


V?B


V?1

V?2=

V?@A

V?


V?


V?

V?

V?


V?


V?

V?

V?


V?


V?

V?

V?


V?	

V?


V?

V?


V?	

V?


V?

V?


V?


V?

V?

V?


V?

V?	

V?
&
W? ? 空间页动态-请求


W?
:
W ?, 被访问者，也就是空间主人的uid


W ?	

W ?


W ?
*
W? 动态偏移history_offset


W?


W?

W?

W?B 秒开参数


W?1

W?2=

W?@A
\
W?N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


W?	

W?


W?
2
W?$ 向下翻页数，默认从1开始


W?	

W?


W?
=
W?/ 来源，空间页：space，直播tab：live


W?


W?

W?
&
X? ? 空间页动态-响应


X?

X ?" 卡片列表


X ?

X ?

X ?

X ? !

X? 历史偏移


X?


X?

X?
(
X? 是否还有更多数据


X?

X?	

X?

Y? ?


Y?"

Y ?&


Y ?

Y ?!

Y ?$%

Z? ?


Z? 

Z ?%


Z ?

Z ?

Z ? 

Z ?#$

Z?


Z?	

Z?


Z?

Z?B


Z?1

Z?2=

Z?@A

Z?


Z?


Z?

Z?

Z?


Z?


Z?

Z?

Z?


Z?


Z?

Z?

Z?


Z?	

Z?


Z?

Z?


Z?	

Z?


Z?

Z?


Z?


Z?

Z?

Z	?


Z	?


Z	?

Z	?

Z
?


Z
?	

Z
?


Z
?

Z?


Z?	

Z?


Z?

[? ?


[?

[ ?


[ ?


[ ?

[ ?

[?


[?


[?

[?

[?


[?


[?

[?

[?


[?	

[?


[?

[?


[?	

[?


[?

[?


[?	

[?


[?

[?


[?	

[?


[?

[?


[?

[?	

[?

[?


[?


[?

[?

[	?


[	?


[	?

[	?

[
?


[
?


[
?

[
?

[?


[?	

[?


[?

[?


[?


[?

[?

\? ?


\?

\ ? 


\ ?

\ ?

\ ?

\ ?

]? ?


]?

] ?


] ?	

] ?


] ?
#
^? ? 动态点赞-请求


^?

^ ? 用户uid


^ ?	

^ ?


^ ?

^?
 动态id


^?


^?

^?
8
^?* 动态类型(透传extend中的dyn_type)


^?	

^?


^?
!
^? 业务方资源id


^?


^?

^?

^? 点赞类型


^?

^?

^?

? ?


?

 ?"


 ?

 ?
%
?" 直接跳转对应uri


?

?
"
?" 作为后缀拼接


?

?
7
_? ?) 最近访问-个人feed流列表-响应


_?

_ ?" 动态列表


_ ?

_ ?

_ ?

_ ? !

_? 偏移量


_?


_?

_?
(
_? 是否还有更多数据


_?

_?	

_?

_? 已读进度


_?


_?

_?

_? 关注状态


_?

_?

_?

_?" 顶部预约卡


_?

_?

_? !
7
`? ?) 最近访问-个人feed流列表-请求


`?
#
` ? 被访问者的 UID


` ?	

` ?


` ?
,
`? 偏移量 第一页可传空


`?


`?

`?
"
`? 标明下拉几次


`?	

`?


`?
"
`? 是否是预加载


`?	

`?


`?
F
`?#8 秒开参数 新版本废弃，统一使用player_args


`?

`?

`?!"
\
`?N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


`?	

`?


`?
4
`?& 服务端生成的透传上报字段


`?


`?

`?

`? 来源


`?


`?

`?

`?B 秒开参数


`?1

`?2=

`?@A
&
a? ? 动态视频页-响应


a?

a ?& 卡片列表


a ?

a ?!

a ?$%

a?& 动态卡片


a?

a?!

a?$%
&
a?. 视频页-我的追番


a?

a?)

a?,-
&
b? ? 动态视频页-请求


b?
&
b ? 透传 update_baseline


b ?


b ?

b ?
%
b? 透传 history_offset


b?


b?

b?

b? 向下翻页数


b?	

b?


b?
;
b?- 刷新方式
 1:向上刷新 2:向下翻页


b?

b?

b?
F
b?#8 秒开参数 新版本废弃，统一使用player_args


b?

b?

b?!"
1
b?# 综合页当前更新的最大值


b?


b?

b?
\
b?N 客户端时区 兼容UTC-14和Etc/GMT+12,时区区间[-12,14] 东八区为8


b?	

b?


b?

b? 来源


b?


b?

b?

b?B 秒开参数


b?1

b?2=

b?@A
0
c? ?" 最近访问-标记已读-请求


c?
"
c ? 被访问者的UID


c ?	

c ?


c ?
"
c? 用户已读进度


c?


c?

c?
4
c?& 服务端生成的透传上报字段


c?


c?

c?
#
d? ? 投票操作-响应


d?

d ? 投票详情


d ?

d ?

d ?
(
d? 投票操作返回状态


d?


d?

d?
#
e? ? 投票操作-请求


e?

e ?
 投票ID


e ?	

e ?


e ?
"
e? 选项索引数组


e?

e?

e?

e?

e? 状态


e?

e?

e?

e?
 动态ID


e?


e?

e?

e? 是否分享


e?

e?	

e?

f? ? 动态卡片


f?
"
f ? 动态卡片类型


f ?

f ?

f ?
1
f?# 转发类型下，源卡片类型


f?

f?

f?

f?  模块内容


f?

f?

f?

f?
"
f? 操作相关字段


f?


f?

f?
4
f?& 该卡片下面是否含有折叠卡


f?	

f?


f?
4
f?& 透传到客户端的埋点字段。


f?


f?

f?
!
g? ?动态卡片列表


g?

g ?" 动态列表


g ?

g ?

g ?

g ? !
"
g? 更新的动态数


g?	

g?


g?

g? 历史偏移


g?


g?

g?
"
g? 更新基础信息


g?


g?

g?
(
g? 是否还有更多数据


g?

g?	

g?
#
? ? 枚举-动态类型


?

 ?" 占位


 ?

 ?

?" 转发


?

?
?
?"1 稿件: ugc、小视频、短视频、UGC转PGC


?

?	

^
?"P pgc：番剧、PGC番剧、PGC电影、PGC电视剧、PGC国创、PGC纪录片


?

?

"
?" 付费更新批次


?

?

?" 折叠


?

?

?" 纯文字


?

?

?" 图文


?

?
%
?" 专栏 原仅phone端


?

?
%
	?" 音频 原仅phone端


	?	

	?
 

?" 通用卡 方形



?


?
 
?" 通用卡 竖形


?

?
)
?" 直播卡 只有转发态


?

?
5
?"' 播单 原仅phone端 只有转发态


?

?
2
?"$ 付费更新批次 只有转发态


?

?

?" 广告卡


?

?	

?" 小程序卡


?


?

?" 订阅卡


?

?

?" 直播推荐卡


?

?

?" 通栏


?


?

?" 合集卡


?

?

?" 新订阅卡


?

?

?"


?	

?

?"


?

?

? ? 表情包类型


?

 ?" 占位


 ?

 ?

?" emoji旧类型


?

?

?" emoji新类型


?

?

?" 大会员表情


?

?

,
? ? 附加大卡-电竞卡样式


?

 ?"	 moba类


 ?

 ?
6
h? ?( 动态-拓展小卡模块-通用小卡


h?

h ? 标题


h ?


h ?

h ?

h? 跳转地址


h?


h?

h?

h? 小图标


h?


h?

h?

h?	 poiType


h?	

h?


h?

h? 类型


h?

h?

h?
"
h? 客户端埋点用


h?


h?

h?

h? 行动点文案


h?


h?

h?

h? 行动点链接


h?


h?

h?

h? 资源rid


h?	

h?


h?
%
h	? 轻浏览是否展示


h	?

h	?	

h	?
6
i? ?( 动态-拓展小卡模块-游戏小卡


i?

i ? 标题


i ?


i ?

i ?

i? 跳转地址


i?


i?

i?

i? 小图标


i?


i?

i?
6
j? ?( 动态-拓展小卡模块-热门小卡


j?

j ? 标题


j ?


j ?

j ?

j? 跳转地址


j?


j?

j?

j? 小图标


j?


j?

j?
3
k? ?% 动态-拓展小卡模块-lbs小卡


k?

k ? 标题


k ?


k ?

k ?

k? 跳转地址


k?


k?

k?

k? 小图标


k?


k?

k?

k?	 poiType


k?	

k?


k?
3
l? ?% 动态-拓展小卡模块-ogv小卡


l?

l ?" ogv小卡


l ?

l ?

l ?

l ? !
6
m? ?( 动态-拓展小卡模块-话题小卡


m?
 
m ? 标题-话题名


m ?


m ?

m ?

m? 跳转地址


m?


m?

m?

m? 小图标


m?


m?

m?
=
n? ?/ 扩展字段，用于动态部分操作使用


n?

n ?
 动态id


n ?


n ?

n ?

n? 业务方id


n?


n?

n?

n? 源动态id


n?


n?

n?
%
n? 转发卡：用户名


n?


n?

n?
%
n? 转发卡：图片url


n?


n?

n?
(
n?' 转发卡：文字内容


n?

n?

n?"

n?%&
"
n?" 填充文字内容


n?

n?

n?

n? !
+
n?" 被转发的源动态类型


n?

n?

n? !
+
n? 分享到站外展示类型


n?


n?

n?

n	? 分享的场景


n	?


n	?

n	?
"
n
? 是否快速转发


n
?

n
?	

n
?
&
n? r_type 分享和转发


n?	

n?


n?
(
n? 数据源的动态类型


n?	

n?


n?

n?
 用户id


n?	

n?


n?

n? 卡片跳转


n?


n?

n?

n?, 透传字段


n?

n?&

n?)+
(
n? 转发卡：用户头像


n?


n?

n?

n? 评论跳转


n?

n?

n?

o? ? 评论扩展


o?
"
o ? 基础跳转地址


o ?


o ?

o ?

o?) 参数部分


o?

o?

o?$

o?'(
(
p? ? 评论扩展参数部分


p?

p ? 参数名


p ?


p ?

p ?

p? 参数值


p?


p?

p?

? ? 折叠类型


?

 ?" 占位


 ?

 ?
"
?" 用户发布折叠


?

?
"
?" 转发超频折叠


?

?
"
?" 联合投稿折叠


?

?
"
?" 动态受限折叠


?

?
3
q? ?% 视频页-我的追番-番剧信息


q?

q ? season_id


q ?	

q ?


q ?

q? 标题


q?


q?

q?

q? 封面图


q?


q?

q?

q? 跳转链接


q?


q?

q?

q? new_ep


q?	

q?


q?

q? 子标题


q?


q?

q?

q? 卡片位次


q?	

q?


q?

? ?


?

 ?"


 ?

 ?

?"


?

?
1
r? ?# 动态-附加卡-商品卡-商品


r?

r ? 图片


r ?


r ?

r ?
-
r?# schemaPackageName(Android用)


r?


r?

r?!"
2
r?$ 商品类型
 1:淘宝 2:会员购


r?	

r?


r?

r? 跳转链接


r?


r?

r?

r? 跳转文案


r?


r?

r?

r? 标题


r?


r?

r?

r? 摘要


r?


r?

r?

r? 价格


r?


r?

r?

r?	 item_id


r?	

r?


r?

r	? schema_url


r	?


r	?

r	?

r
?) open_white_list


r
?

r
?

r
?#

r
?&(

r? use_web_v2


r?

r?	

r?

r?	 ad mark


r?


r?

r?

s? ?


s?

s ?


s ?	

s ?


s ?

s?


s?	

s?


s?

s?


s?	

s?


s?

s?


s?


s?

s?

s?


s?	

s?


s?

s?


s?	

s?


s?

t? ? 高亮文本


t?

t ? 展示文本


t ?


t ?

t ?

t?& 高亮类型


t?

t?!

t?$%

t?


t?


t?

t?

t?


t?


t?

t?
"
? ? 文本高亮枚举


?

 ?" 默认


 ?

 ?

?" 高亮


?

?

u? ?


u?

u ?


u ?


u ?

u ?

u?


u?


u?

u?

v? ?


v?

v ?


v ?


v ?

v ?

v?


v?


v?

v?

v?


v?


v?

v?

v?


v?


v?

v?
&
? ? 枚举-附加卡样式


?

 ?"


 ?

 ?

?"


?

?
U
w? ?G 动态-拓展小卡模块-ogv小卡-(one of 片单、榜单、分区)


w?

w ? 标题


w ?


w ?

w ?

w? 跳转地址


w?


w?

w?

w? 小图标


w?


w?

w?
"
w? 客户端埋点用


w?


w?

w?

x? ?


x?

x ?


x ?	

x ?


x ?

x?


x?


x?

x?
"
y? ? 外露交互模块


y?
"
y ?" 外露模块类型


y ?

y ?

y ? !
"
y?" 外露模块文案


y?

y?

y?

y? !
B
y?4 外露模块uri相关 根据type不同用法不同


y?


y?

y?

y?
 动态id


y?


y?

y?

y? 评论mid


y?	

y?


y?

y?'


y?

y?

y?"

y?%&

y?


y?

y?

y?

y?


y?


y?

y?

z? ?


z?

z ?


z ?	

z ?


z ?

? ?


?

 ?"


 ?

 ?

?"


?

?

{? ? 点赞动画


{?

{ ? 开始动画


{ ?


{ ?

{ ?

{? 过程动画


{?


{?

{?

{? 结束动画


{?


{?

{?

{? id


{?	

{?


{?
"
|? ? 点赞拓展信息


|?

| ?  点赞动画


| ?

| ?

| ?

|? 是否点赞


|?

|?	

|?
#
}? ? 点赞列表-响应


}?
"
} ?# 用户模块列表


} ?

} ?

} ?

} ?!"
(
}? 是否还有更多数据


}?

}?	

}?

}? 点赞总数


}?	

}?


}?
#
~? ? 点赞列表-请求


~?

~ ?
 动态ID


~ ?


~ ?

~ ?

~? 动态类型


~?	

~?


~?
!
~? 业务方资源id


~?	

~?


~?
'
~?上一页最后一个uid


~?	

~?


~?

~? 下拉页数


~?	

~?


~?

? ? 点赞用户


?

 ? 用户mid


 ?	

 ?


 ?

? 用户昵称


?


?

?
"
? 点击跳转链接


?


?

?

?? ? 直播信息


??
E
? ?6 是否在直播
 0:未直播 1:正在直播 (废弃)


? ?	

? ?


? ?

?? 跳转链接


??


??

??

?? 直播状态


??

??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

??


??	

??


??

? ? 直播状态


?

 ?" 未直播


 ?

 ?

?" 直播中


?

?

?" 轮播中


?

?
"
? ? 外露模块类型


?

 ?"


 ?

 ?

?"


?

?
2
?? ?# 动态-附加卡-电竞卡-战队


??

? ?
 战队ID


? ?	

? ?


? ?

?? 战队名


??


??

??

?? 战队图标


??


??

??

?? 日间色值


??


??

??

?? 夜间色值


??


??

??
J
?? ?; 动态列表渲染部分-详情模块-小程序/小游戏


??

? ? 小程序id


? ?	

? ?


? ?

?? 跳转地址


??


??

??

?? 主标题


??


??

??

?? 副标题


??


??

??

?? 封面图


??


??

??

?? 小程序icon


??


??

??
 
?? 小程序标题


??


??

??

?? 按钮文案


??


??

??
+
?? ? 动态-详情模块-稿件


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??

?? 秒开地址


??


??

??
(
??! 视频封面展示项 1


??


??

?? 
(
??! 视频封面展示项 2


??


??

?? 
(
??! 封面视频展示项 3


??


??

?? 

?? avid


??	

??


??

?? cid


??	

??


??
 
?? 视频源类型


??

??

??

?	? 尺寸信息


?	?

?	?

?	?
5
?
?#& 角标，多个角标之前有间距


?
?

?
?

?
?

?
? "
)
?? 是否能够自动播放


??

??


??

?? stype


??

??

??

?? 是否PGC


??

??	

??
#
?? inline播放地址


??


??

??

?? PGC的epid


??	

??


??

?? 子类型


??	

??


??

?? PGC的ssid


??	

??


??

?? 播放按钮


??


??

??

?? 时长


??	

??


??

?? 跳转地址


??


??

??
,
?? 番剧是否为预览视频


??

??	

??
;
??,, 新角标，多个角标之前没有间距


??

??

??&

??)+
)
?? 当前是否是pgc正片


??

??	

??
&
??" 是否是预约召回


??

??

??!

?? bvid


??


??

??

?? 播放数


??	

??


??
C
?? ?4 动态列表渲染部分-详情模块-专栏模块


??

? ?
 专栏id


? ?	

? ?


? ?

?? 跳转地址


??


??

??

?? 标题


??


??

??

?? 文案部分


??


??

??

?? 配图


??

??

??

??
 
?? 阅读量标签


??


??

??

?? 模板类型


??	

??


??
=
?? ?. 动态列表渲染部分-详情模块-通用


??

? ?
 物料id


? ?	

? ?


? ?

?? 跳转地址


??


??

??

?? 标题


??


??

??
3
??$ 描述 漫画卡标题下第一行


??


??

??

?? 封面


??


??

??
4
??% 标签1 漫画卡标题下第二行


??


??

??
#
?? 所属业务类型


??	

??


??

?? 镜像数据ID


??	

??


??

?? 卡片样式


??

??

??

?	?# 角标


?	?

?	?

?	?

?	? "

?
?!


?
?

?
?

?
? 

? ?


?

 ?"


 ?

 ?

?"


?

?

?"


?

?
7
?? ?( 动态-详情模块-付费课程批次


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??

?? 跳转地址


??


??

??
*
?? 展示项 1(本集标题)


??


??

??
6
??' 展示项 2(更新了多少个视频)


??


??

??

?? 角标


??

??

??

?? 播放按钮


??


??

??
7
?? ?( 动态-详情模块-付费课程系列


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??

?? 跳转地址


??


??

??
*
?? 展示项 1(更新信息)


??


??

??

?? 描述信息


??


??

??

?? 角标


??

??

??

?? 播放按钮


??


??

??
C
?? ?4 动态列表渲染部分-详情模块-图文模块


??

? ?& 图片


? ?

? ?

? ?!

? ?$%

?? 跳转地址


??


??

??

??
 图文ID


??	

??


??
=
?? ?. 动态列表渲染部分-详情模块-图文


??

? ? 图片链接


? ?


? ?

? ?

?? 图片宽度


??	

??


??

?? 图片高度


??	

??


??

?? 图片大小


??	

??


??

??$ 图片标签


??

??

??

??"#
D
?? ?5 动态列表渲染部分-详情模块-图文-标签


??

? ? 标签类型


? ?

? ?

? ?

??  标签详情


??

??

??
D
?? ?5 动态列表部分-详情模块-图文-标签详情


??

? ? 跳转链接


? ?


? ?

? ?

?? 标签内容


??


??

??

??
 坐标-x


??	

??


??

??
 坐标-y


??	

??


??

?? 方向


??	

??


??
3
??$ 来源
 0:未知 1:淘宝 2:自营


??	

??


??

??
 商品id


??	

??


??

?? 用户mid


??	

??


??

??
 话题id


??	

??


??

?	? lbs信息


?	?


?	?

?	?
#
?
? 商品标签链接


?
?


?
?

?
?
"
? ? 图文标签类型


?

 ?" 占位


 ?

 ?

?" 普通标签


?

?

?" 商品标签


?

?

?" 用户昵称


?

?

?" 话题名称


?

?

?" lbs标签


?

?
C
?? ?4 动态列表渲染部分-详情模块-转发模块


??
0
? ?! 动态转发核心模块 套娃


? ?

? ?

? ?
0
??! 透传类型
 0:分享 1:转发


??	

??


??
=
?? ?. 动态列表渲染部分-详情模块-直播


??

? ? 房间号


? ?	

? ?


? ?

?? 跳转地址


??


??

??
 
?? 直播间标题


??


??

??
 
?? 直播间封面


??


??

??
*
?? 标题1 例: 陪伴学习


??


??

??
+
?? 标题2 例: 54.6万人气


??


??

??

?? 直播状态


??

??

??

?? 直播角标


??

??

??
&
??! 是否是预约召回


??

??

?? 
C
?? ?4 动态列表渲染部分-详情模块-直播推荐


??

? ? 直播数据


? ?


? ?

? ?
&
??! 是否是预约召回


??

??

?? 

??


??

??

??
=
?? ?. 动态列表渲染部分-详情模块-播单


??

? ?
 播单id


? ?	

? ?


? ?

?? 跳转地址


??


??

??

?? 主标题


??


??

??

?? 副标题


??


??

??

?? 封面图


??


??

??

?? 封面类型


??	

??


??

?? 角标


??

??

??
C
?? ?4 动态列表渲染部分-详情模块-音频模块


??

? ?
 音频id


? ?	

? ?


? ?

?? 跳转地址


??


??

??

?? upId


??	

??


??

?? 歌名


??


??

??

?? 专辑封面


??


??

??

?? 展示项1


??


??

??

?? upper


??


??

??
(
?? ? 动态-详情模块-pgc


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??

?? 秒开地址


??


??

??
(
??! 视频封面展示项 1


??


??

?? 
(
??! 视频封面展示项 2


??


??

?? 
(
??! 封面视频展示项 3


??


??

?? 

?? cid


??	

??


??

?? season_id


??	

??


??

?? epid


??	

??


??

?	? aid


?	?	

?	?


?	?
 
?
? 视频源类型


?
?

?
?

?
?

?? 番剧类型


??

??

??
,
?? 番剧是否为预览视频


??

??	

??

?? 尺寸信息


??

??

??
5
??#& 角标，多个角标之前有间距


??

??

??

?? "
)
?? 是否能够自动播放


??

??


??

?? season


??

??

??

?? 播放按钮


??


??

??

?? 时长


??	

??


??

?? 跳转地址


??


??

??
;
??,, 新角标，多个角标之前没有间距


??

??

??&

??)+
)
?? 当前是否是pgc正片


??

??	

??
@
?? ?1 动态列表渲染部分-详情模块-订阅卡


??

? ? 卡片物料id


? ?	

? ?


? ?

?? 广告创意id


??	

??


??

?? 跳转地址


??


??

??

?? 标题


??


??

??

?? 封面图


??


??

??

?? 广告标题


??


??

??

?? 角标


??

??

??

?? 小提示


??


??

??
#
?? ? 动态新附加卡


??

? ?)样式类型


? ?

? ?$

? ?'(
%
? ?? 新订阅卡数据


? ?


??0


??

??+

??./

??) 直播推荐


??

??$

??'(

? ?


?

 ?," 占位


 ?'

 ?*+

?," 直播


?'

?*+

?," 图文


?'

?*+
3
?? ?$ 动态列表渲染部分-UGC合集


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??

?? 秒开地址


??


??

??
(
??! 视频封面展示项 1


??


??

?? 
(
??! 视频封面展示项 2


??


??

?? 
(
??! 封面视频展示项 3


??


??

?? 

?? 卡片物料id


??	

??


??
#
?? inline播放地址


??


??

??
)
?? 是否能够自动播放


??

??


??

?	? 播放按钮


?	?


?	?

?	?

?
? avid


?
?	

?
?


?
?

?? cid


??	

??


??

?? 尺寸信息


??

??

??

?? 时长


??	

??


??

?? 跳转地址


??


??

??

? ? 播放器类型


?

 ?" 本地


 ?

 ?

?" UGC


?

?

?" PGC


?

?

?" 直播


?

?

?" 小视频


?

?
0
?? ?! 查看更多-列表单条数据


??

? ? 用户mid


? ?	

? ?


? ?
*
??  特别关注
 0:否 1:是


??	

??


??
0
??! 小红点状态
 0:没有 1:有


??	

??


??

??$ 直播信息


??

??

??"#

?? 昵称


??


??

??

?? 头像


??


??

??

??  认证信息


??

??

??
 
?? 大会员信息


??

??

??

?? 关注状态


??

??

??

?? ?

??
6
? ?' 直播状态
 0:未直播 1:直播中


? ?

? ?	

? ?

?? 房间号


??	

??


??

?? 跳转地址


??


??

??

?? ? 动态模块


??

? ?" 类型


? ?

? ?

? ? !

? ??

? ?


??' 用户模块 1


??

??"

??%&
%
??) 争议黄条模块 2


??

??$

??'(
%
??# 动态正文模块 3


??

??

??!"
"
??) 动态卡模块 4


??

??$

??'(
%
??+ 点赞外露(废弃)


??

??&

??)*

??' 小卡模块 6


??

??"

??%&

??/ 大卡模块 5


??

??*

??-.

??# 计数模块 8


??

??

??!"

?	?$ 折叠模块 9


?	?

?	?

?	?!#
%
?
?* 评论外露(废弃)


?
?

?
?$

?
?')
6
??2' 外露交互模块(点赞、评论) 7


??

??,

??/1
-
??7 转发卡-原卡用户模块


??

??1

??46

??  广告卡


??

??

??

??( 通栏


??

??"

??%'
#
??- 获取物料失败


??

??'

??*,

??/ 分享组件


??

??)

??,.
#
??. 相关推荐模块


??

??(

??+-

??" 顶部模块


??

??

??!

??( 底部模块


??

??"

??%'
&
??, 转发卡计数模块


??

??&

??)+

??&


??

?? 

??#%

??&


??

?? 

??#%

??<


??

??6

??9;

??)


??

??#

??&(

??1


??

??+

??.0

??&


??

?? 

??#%
4
?? ?% 动态列表-用户模块-广告卡


??
Z
? ?#K 广告透传信息
 google.protobuf.Any source_content = 1;
 用户模块


? ?

? ?

? ?!"

??


??	

??


??

?? 


??


??

??

?? 


??


??

??

?? 


??


??

??
'
?? ? 动态-附加卡模块


??

? ? 类型


? ?

? ?

? ?

? ??

? ?


?? 废弃


??

??

??

?? 


??

??

??

?? 废弃


??

??

??

??"


??

??

?? !

??"


??

??

?? !

??  投票


??

??

??

??


??

??

??
%
?? up主预约发布卡


??

??

??
"
?	? 附加卡物料ID


?	?	

?	?


?	?

?
?"


?
?

?
?	

?
?!
'
?? ? 动态-发布人模块


??

? ? 用户mid


? ?	

? ?


? ?

??  时间标签


??


??

??

?? 用户详情


??

??

??

??# 装扮卡片


??

??

??!"
#
?? 点击跳转链接


??


??

??
2
??(# 右侧操作区域 - 三点样式


??

??

??#

??&'
/
??)  右侧操作区域样式枚举


??

??$

??'(
2
??-# 右侧操作区域 - 按钮样式


??

??(

??+,
w
??h 是否关注
 1:关注 0:不关注 默认0，注：点赞列表使用，其他场景不使用该字段


??	

??


??

?	? 关注状态


?	?

?	?

?	?
2
?
?# 右侧操作区域 - 提权样式


?
?


?
?

?
?
#
?? 是否展示关注


??

??	

??

?? 是否置顶


??

??	

??
=
?? ?. 动态列表渲染部分-用户模块-按钮


??

? ? 图标


? ?


? ?

? ?

?? 文案


??


??

??

?? 状态


??	

??


??

??
 物料ID


??	

??


??
.
? ?  右侧操作区域样式枚举


?

 ?&" 占位


 ?!

 ?$%

?," 三点


?'

?*+

?(" 按钮类型


?#

?&'

?(" 提权


?#

?&'
7
?? ?( 动态列表-用户模块-转发模板


??

? ?0 展示标题


? ?

? ?%

? ?&+

? ?./
&
?? 源卡片跳转链接


??


??

??

?? 用户uid


??	

??


??

??  时间标签


??


??

??
#
?? 是否展示关注


??

??	

??

?? 源up主头像


??


??

??

?? 双向关系


??

??

??
2
??(# 右侧操作区域 - 三点样式


??

??

??#

??&'
C
?? ?4 动态列表-用户模块-转发模板-title部分


?? 

? ? 文案


? ?


? ?

? ?

?? 跳转链接


??


??

??
$
?? ? 动态列表-通栏


??

? ? 模块标题


? ?


? ?

? ?

?? 卡片类型


??

??

??

? ?? 卡片


? ?


??"

??

??

?? !
#
?? 不感兴趣文案


??


??

??
#
?? 不感兴趣图标


??


??

??
)
? ? 动态列表-通栏类型


?

 ? "


 ?

 ?

? "


?

?
$
?? ? 动态通栏-用户


??

? ?+ 卡片列表


? ?

? ?!

? ?"&

? ?)*
-
?? ? 动态通栏-推荐用户卡


??

? ? up主头像


? ?


? ?

? ?

?? up主昵称


??


??

??

??
 up主uid


??	

??


??

?? 直播状态


??

??

??

??  认证信息


??

??

??
 
?? 大会员信息


??

??

??

?? 标签信息


??


??

??

??  按钮


??

??

??

?? 跳转地址


??


??

??

?? ? 底部模块


??

? ? 计数模块


? ?

? ?

? ?
#
?? ? 评论外露模块


??
&
? ?) 评论外露展示项


? ?

? ?

? ?$

? ?'(
*
?? ? 动态-描述文字模块


??
1
? ?"" 描述信息(已按高亮拆分)


? ?

? ?

? ?

? ? !
#
?? 点击跳转链接


??


??

??

?? 文本原本


??


??

??
&
?? ? 正文商品卡参数


??
3
? ?$ 商品类型
 1:淘宝 2:会员购


? ?	

? ?


? ?

?? 跳转链接


??


??

??

?? schema_url


??


??

??

??	 item_id


??	

??


??
 
??( open_white_list


??

??

??#

??&'

?? use_web_v2


??

??	

??

??	 ad mark


??


??

??
.
??# schemaPackageName(Android用)


??


??

??!"
-
?? ? 动态-争议小黄条模块


??

? ? 标题


? ?


? ?

? ?

?? 描述内容


??


??

??

?? 跳转链接


??


??

??
$
?? ? 动态-详情模块


??

? ? 类型


? ?

? ?

? ?

? ??

? ?


??&稿件


??

??!

??$%

??pgc


??

??

??
#
??-付费课程-系列


??

??(

??+,
#
??+付费课程-批次


??

??&

??)*

??&
转发卡


??

??!

??$%

?? 图文


??

??

??

??&专栏


??

??!

??$%

??"音频


??

??

?? !

?	?%通用卡方


?	?

?	?

?	?"$

?
?(
直播卡


?
?

?
?"

?
?%'

??+播单


??

??%

??(*

??%小程序卡


??

??

??"$

??1
订阅卡


??

??+

??.0

??*直播推荐卡


??

??$

??')

??,
UGC合集


??

??&

??)+

??8
订阅卡


??

??2

??57
(
? ? 动态详情模块类型


?

 ?" 稿件


 ?

 ?

?" pgc


?

?
#
?" 付费课程-系列


?

?
#
?" 付费课程-批次


?

?

?" 转发卡


?

?

?" 图文


?

?

?" 专栏


?

?

?" 音频


?

?

?" 通用卡方


?

?

	?" 直播卡


	?

	?


?" 播单



?


?

?" 小程序卡


?

?

?" 订阅卡


?

?

?" 直播推荐卡


?

?

?" UGC合集


?

?

?"" 订阅卡


?

?!
$
?? ? 动态-小卡模块


??

? ?) 详情


? ?

? ?

? ?$

? ?'(
0
?? 模块整体跳转uri
" 废弃


??


??

??
*
?? ? 动态-拓展小卡模块


??

? ? 类型


? ?

? ?

? ?

? ?? 卡片详情


? ?


??( 废弃


??

??#

??&'

??$ 废弃


??

??

??"#

??$ 废弃


??

??

??"#

??& 废弃


??

??!

??$%

??*


??

??%

??()

??%


??

?? 

??#$
$
?? ? 动态-折叠模块


??

? ? 折叠分类


? ?

? ?

? ?

?? 折叠文案


??


??

??
#
?? 被折叠的动态


??


??

??
)
??% 被折叠的用户信息


??

??

?? 

??#$
#
?? ? 外露交互模块


??
#
? ?2 外露交互模块


? ?

? ?

? ?-

? ?01
)
?? ? 获取物料失败模块


??

? ? 图标


? ?


? ?

? ?

?? 文案


??


??

??
*
?? ? 动态-点赞用户模块


??

? ?% 点赞用户


? ?

? ?

? ? 

? ?#$

?? 文案


??


??

??

?? ? 推荐模块


??

? ? 用户头像


? ?

? ?

? ?
#
??  推荐卡片列表


??

??

??

??
2
??# 透传到客户端的埋点字段


??


??

??
#
?? ? 相关推荐模块


??

? ? 模块标题


? ?


? ?

? ?

?? 图片


??


??

??

?? 标签


??


??

??

?? 标题


??


??

??

?? 跳转链接


??


??

??
)
??( 序列化的广告信息


??

?? 

??!#

??&'

?? ? 分享模块


??

? ? 展示标题


? ?


? ?

? ?
#
??- 分享组件列表


??

??

??(

??+,

?? share_origin


??


??

??

??
 业务id


??


??

??

?? sid


??


??

??
$
?? ? 动态-计数模块


??

? ? 转发数


? ?	

? ?


? ?

?? 点赞数


??	

??


??

?? 评论数


??	

??


??
#
?? 点赞拓展信息


??

??

??

?? 禁评


??

??	

??

?? 禁转


??

??	

??
)
?? 点击评论跳转链接


??


??

??

?? 禁评文案


??


??

??

?? 禁转文案


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??!


??

??

??

?? 

??#


??

??	

??!"

??


??	

??


??

??


??


??

??

??


??


??

??

??


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??

??

??

?? ? 顶部模块


??

? ?( 三点模块


? ?

? ?

? ?#

? ?&'

?? ?


??

? ?


? ?


? ?

? ?

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??


??

??

?? ?


??

? ?


? ?

? ?

? ?

?? ?


??

? ?


? ?


? ?

? ?

?? ? 认证名牌


??

? ? nid


? ?	

? ?


? ?

?? 名称


??


??

??

?? 图片地址


??


??

??

?? 小图地址


??


??

??

?? 等级


??


??

??

?? 获取条件


??


??

??

 ? ?

 ?

  ?"


  ?

  ?

 ?"


 ?

 ?

 ?"


 ?

 ?

 ?"


 ?

 ?

 ?"


 ?

 ?

 ?"


 ?

 ?

?? ?
 最新ep


??

? ? 最新话epid


? ?	

? ?


? ?

?? 更新至XX话


??


??

??
&
?? 更新剧集的封面


??


??

??

?? ? 空响应


??

?? ? 空请求


??

?? ?


??

? ?


? ?

? ?

? ?

??


??	

??


??

??


??


??

??

??


??

??

??

??


??


??

??

??


??


??

??

?? ?


??

? ?+


? ?

? ? 

? ?!&

? ?)*

??


??

??	

??

??


??	

??


??

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??	

??


??

?? ?


??

? ?$


? ?

? ?

? ?

? ?"#

??


??	

??


??

??


??

??	

??

??B


??1

??2=

??@A

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??	

??


??

?? ?

??

? ?

? ?	

? ?


? ?

? ??

? ?


??-

??

??(

??+,

??-

??

??(

??+,

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

?? 


??


??

??

??


??	

??


??

??


??


??

??

??


??	

??


??

??


??


??

??

??


??


??

??

??


??

??	

??

?	?


?	?


?	?

?	?

?
?


?
?	

?
?


?
?

??


??	

??


??

??


??


??

??

??


??	

??


??

??


??	

??


??

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

??$


??


??

??"#

??


??	

??


??

??


??


??

??

??


??	

??


??

??


??


??

??

??


??


??

??

??


??


??

??

?	?


?	?	

?	?


?	?

?
?


?
?	

?
?


?
?

??


??


??

??

??


??	

??


??

?? ? 认证信息


??
0
? ?! 127:未认证 0:个人 1:机构


? ?	

? ?


? ?

?? 认证描述


??


??

??

?? 是否关注


??	

??


??
 
?? ? PGC单季信息


??

? ? 是否完结


? ?	

? ?


? ?

?? 标题


??


??

??

?? 类型


??	

??


??
#
?? ? 秒开通用参数


??

? ? 清晰度


? ?	

? ?


? ?

?? 流版本


??	

??


??

?? 流类型


??	

??


??
)
?? 是否强制使用域名


??	

??


??

??
 是否4k


??	

??


??

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

??


??


??

??

?? ?


??

? ? 标题


? ?


? ?

? ?

?? 封面图


??


??

??
(
??$ 视频封面展示项 1


??

??

??"#
(
??! 视频封面展示项 1


??


??

?? 

?? 秒开地址


??


??

??

?? 是否PGC


??

??	

??

?? aid


??	

??


??

??


??

??

??

??


??	

??


??

?	?!


?	?


?	?

?	? 

?
? 


?
?	

?
?


?
?

??!


??


??

?? 
(
?? ? 推荐UP主用户模块


??

? ? 用户详情


? ?

? ?

? ?
2
??# 描述：粉丝数、推荐理由


??


??

??

?? 关注状态


??

??

??
#
?? ? 推荐卡片列表


??

? ? 卡片类型


? ?

? ?

? ?

? ?? 卡片列表


? ?


??%


??

?? 

??#$
)
?? ? 分区聚类推荐选项


??
)
? ? 视频是否展示标题


? ?

? ?	

? ?

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??
(
!? ? 推荐模块数据类型


!?

! ?" 稿件


! ?

! ?

!?" 动态


!?

!?
"
?? ? 推荐up主入参


??

? ?

? ?	

? ?


? ?

"? ? 刷新方式


"?

" ?" 刷新列表


" ?

" ?

"?" 请求历史


"?

"?

?? ? 关注关系


??

? ? 关注状态


? ?

? ?

? ?

?? 关注


??	

??


??

?? 被关注


??	

??


??

?? 文案


??


??

??
#
#? ? 关注关系 枚举


#?
N
# ?@ 1-未关注 2-关注 3-被关注 4-互相关注 5-特别关注


# ?

# ?

#?!

#?

#? 

#?

#?

#?

#?!

#?

#? 

#?'

#?"

#?%&

#? 

#?

#?
$
?? ? 转发列表-请求


??

? ?
 动态ID


? ?


? ?

? ?

?? 动态类型


??	

??


??
"
?? 业务方资源id


??	

??


??
T
??E 偏移,使用上一页回包中的offset字段；第一页不传。


??


??

??

?? 来源


??


??

??

?? 评论类型


??

??

??
$
?? ? 转发列表-响应


??

? ?" 列表


? ?

? ?

? ?

? ? !

?? 偏移


??


??

??
#
?? 是否还有更多


??

??	

??

?? 转发总数


??	

??


??

?? 评论类型


??

??

??

$? ? 评论类型


$?

$ ?" 热门评论


$ ?

$ ?

$?" 普通评论


$?

$?

%? ?


%?

% ?."


% ?)

% ?,-

%?+"


%?&

%?)*

&? ?


&?

& ?" 占位


& ?

& ?

&?" 预约召回


&?

&?

?? ?


??

? ?"


? ?

? ?

? ?

? ? !

?? ?


??

? ?


? ?	

? ?


? ?

??


??	

??


??

?? ?


??

? ?"


? ?

? ?

? ?

? ? !

??


??

??

??

?? ?


??

? ?


? ?


? ?

? ?

?? ?


??

? ?


? ?


? ?

? ?

??&


??

??!

??$%

??&


??

??

??!

??$%

?? ?


??

? ?


? ?


? ?

? ?

??"


??

??

??

?? !

??


??


??

??

??


??	

??


??

??


??

??	

??

??


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??&


??

??!

??$%

??'


??

??

??"

??%&

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??


??

??

??


??


??

??

??


??

??	

??

?? ?


??

? ?


? ?	

? ?


? ?

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??
#
?? ? 分享渠道组件


??

? ? 分享名称


? ?


? ?

? ?
#
?? 分享按钮图片


??


??

??

?? 分享渠道


??


??

??
V
??G 预约卡分享图信息，仅分享有预约信息的动态时存在


??

??

??
)
?? ? 预约卡分享图信息


??

? ? 展示标题


? ?


? ?

? ?
&
?? 描述(时间+类型)


??


??

??
$
?? 二维码附带icon


??


??

??
&
?? 二维码附带文本


??


??

??

?? 二维码url


??


??

??

??#


??

??

??!"

'? ?


'?

' ?"


' ?

' ?

'?"


'?

'?

?? ? 排序类型


??
K
? ?< 排序策略
 1:推荐排序 2:最常访问 3:最近关注


? ?	

? ?

? ?
#
?? 排序策略名称


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??	

??


??

??


??


??

??

??


??

??

??

?? ?


??

? ?


? ?

? ?

? ?

??


??


??

??

??


??	

??


??

??


??	

??


??

? ??

? ?


??'


??

??"

??%&

(? ?


(?

( ?"


( ?

( ?

(?"


(?

(?

(?"


(?

(?

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

)? ?


)?

) ?"


) ?


) ?

)?"


)?	

)?

)?"


)?


)?

)?"


)?	

)?

)?"


)?


)?

)?"


)?	

)?

?? ? 三点-关注


??

? ? attention icon


? ?


? ?

? ?
)
?? 关注时显示的文案


??


??

??
#
??" not attention icon


??


??

?? !
,
??" 未关注时显示的文案


??


??

?? !
#
??) 当前关注状态


??

??$

??'(
)
*? ? 枚举-三点关注状态


*?

* ?"


* ?

* ?

*?"


*?

*?
4
?? ?% 三点-自动播放 旧版不维护


??

? ? open icon


? ?


? ?

? ?
&
?? 开启时显示文案


??


??

??

?? close icon


??


??

??
&
?? 关闭时显示文案


??


??

??
(
?? 开启时显示文案v2


??


??

??
(
?? 关闭时显示文案v2


??


??

??
$
?? 仅wifi/免流 icon


??


??

??
&
?? 仅wifi/免流 文案


??


??

??

?? open icon v2


??


??

??

?	? close icon v2


?	?


?	?

?	?

?? ? 三点-评论


??
&
? ?# 精选评论区功能


? ?

? ?

? ?!"
(
?? up关闭评论区功能


??

??

??

?? icon


??


??

??

?? 标题


??


??

??
G
?? ?8 三点-默认结构(使用此背景、举报、删除)


??

? ? icon


? ?


? ?

? ?

?? 标题


??


??

??

?? 跳转链接


??


??

??

?? id


??


??

??

??%


??

?? 

??#$

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??
$
?? ? 三点-不感兴趣


??

? ? icon


? ?


? ?

? ?

?? 标题


??


??

??

?? ? 三点-收藏


??

? ? icon


? ?


? ?

? ?

?? 标题


??


??

??

??
 物料ID


??	

??


??

?? 是否订阅


??

??	

??
#
?? 取消收藏图标


??


??

??
#
?? 取消收藏文案


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??


??

??

??.


??

??)

??,-

??


??	

??


??

??


??


??

??

?? ?


??!

? ?


? ?


? ?

? ?

??


??


??

??

??


??


??

??

??


??


??

??

?? ? 三点Item


??

? ?类型


? ?

? ?

? ?

? ??

? ?


??& 默认结构


??

??!

??$%

??+ 自动播放


??

??&

??)*

??" 分享


??

??

?? !

??* 关注


??

??%

??()

??  稍后在看


??

??

??

??& 不感兴趣


??

??!

??$%

??( 收藏


??

??#

??&'

?? 置顶


??

??

??

?	?' 评论


?	?

?	?!

?	?$&

?
?!


?
?

?
?

?
? 

??8


??!

??"2

??57

?? ? 三点-分享


??

? ? icon


? ?


? ?

? ?

?? 标题


??


??

??

??0 分享渠道


??

??#

??$+

??./
 
?? 分享渠道名


??


??

??
V
??G 预约卡分享图信息，仅分享有预约信息的动态时存在


??

??

??
$
?? ? 三点-分享渠道


??

? ? icon


? ?


? ?

? ?

?? 名称


??


??

??

?? ? 三点-置顶


??

? ? icon


? ?


? ?

? ?

?? 标题


??


??

??

?? 状态


??

??

??

?? ?


??!

? ?


? ?


? ?

? ?

??


??


??

??

??


??


??

??

??


??	

??


??

??


??	

??


??

??


??	

??


??

??


??


??

??

+? ? 三点类型


+?

+ ?" 占位


+ ?

+ ?

+?" 使用此背景


+?

+?

+?" 自动播放


+?

+?

+?" 分享


+?	

+?

+?" 稍后再播


+?

+?

+?" 关注


+?

+?

+?" 举报


+?


+?

+?" 删除


+?


+?

+?" 不感兴趣


+?

+?

+	?" 收藏


+	?

+	?

+
?" 置顶


+
?

+
?


+?" 评论


+?

+?

+?"


+?

+?

+?"


+?

+?

+?"


+?

+?
$
?? ? 三点-稍后在看


??

? ? addition icon


? ?


? ?

? ?
&
?? 已添加时的文案


??


??

??
!
??  no addition icon


??


??

??
&
??  未添加时的文案


??


??

??

?? avid


??	

??


??

,? ?


,?

, ?"


, ?


, ?

,?"


,?	

,?
 
?? ? 顶部预约卡


??

? ? 预约卡


? ?

? ?

? ?

? ?
;
??, 折叠数量，大于多少个进行折叠


??	

??


??

-? ? 状态


-?

- ?" 默认 置顶


- ?

- ?

-?" 取消置顶


-?

-?
)
?? ? 话题广场操作按钮


??

? ? 按钮图标


? ?


? ?

? ?

?? 按钮文案


??


??

??

?? 跳转


??


??

??

??


??

??	

??

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??


??

??

??


??


??

??

??


??


??

??

??


??


??

??
'
?? ? 综合页-话题广场


??

? ? 模块标题


? ?


? ?

? ?

??/ 话题列表


??

??

??*

??-.

?? 发起活动


??

??

??

??  查看更多


??

??

??
&
?? 透传服务端上报


??


??

??
.
?? ? 综合页-话题广场-话题


??

? ? 前置图标


? ?


? ?

? ?
#
?? 前置图标文案


??


??

??

??
 话题id


??	

??


??

?? 话题名


??


??

??

?? 跳转链接


??


??

??

?? 卡片位次


??	

??


??
&
?? 透传服务端上报


??


??

??

??


??


??

??

??


??	

??


??

?	?


?	?


?	?

?	?

?
?


?
?


?
?

?
?

?? ?


??

? ?!


? ?

? ?

? ?

? ? 

??


??

??	

??

??


??


??

??

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

?? ?


??

? ?


? ?	

? ?


? ?

??


??


??

??

??


??


??

??

??


??

??

??

??


??


??

??

??


??


??

??

??


??


??

??

?? ?


??

? ?


? ?


? ?

? ?

??


??

??

??

??


??

??

??

?? ?


??

? ?


? ?

? ?

? ?

?? ?


??

? ?


? ?	

? ?


? ?
*
??  ?  综合页-无关注列表


?? 
#
? ?  标题展示文案


? ? 


? ? 

? ? 
 
?? ' 无关注列表


?? 

?? 

?? "

?? %&

?? 	 trackID


?? 


?? 

?? 
*
??  ?  综合页-无关注列表


?? 
 
? ?  是否有更新


? ? 

? ? 	

? ? 

??  up主头像


?? 


?? 

?? 

??  up主昵称


?? 


?? 

?? 

?? 
 up主uid


?? 	

?? 


?? 
(
??  排序字段 从1开始


?? 	

?? 


?? 

??  直播状态


?? 

?? 

?? 

??   认证信息


?? 

?? 

?? 
 
??  大会员信息


?? 

?? 

?? 

?? 
 up介绍


?? 


?? 

?? 

?	?  标签信息


?	? 


?	? 

?	? 

?
? ! 按钮


?
? 

?
? 

?
?  

??  跳转地址


?? 


?? 

?? 
1
??  ? " 动态顶部up列表-up主信息


?? 
 
? ?  是否有更新


? ? 

? ? 	

? ? 

??  up主头像


?? 


?? 

?? 

??  up主昵称


?? 


?? 

?? 

?? 
 up主uid


?? 	

?? 


?? 
(
??  排序字段 从1开始


?? 	

?? 


?? 

?? $ 用户类型


?? 

?? 

?? "#
'
?? ( 直播头像样式-日


?? 

?? #

?? &'
'
?? * 直播头像样式-夜


?? 

?? %

?? ()

??  直播埋点


?? 	

?? 


?? 

?	?  直播状态


?	? 

?	? 

?	? 

?
?  分割线


?
? 

?
? 	

?
? 

??  跳转


?? 


?? 

?? 
(
??  UP主预约上报使用


?? 

?? 	

?? 
*
??  ?  最常访问-查看更多


?? 

? ?  文案


? ? 


? ? 

? ? 

??  跳转地址


?? 


?? 

?? 

??  ?  用户信息


?? 

? ?  用户mid


? ? 	

? ? 


? ? 

??  用户昵称


?? 


?? 

?? 

??  用户头像


?? 


?? 

?? 

??   认证信息


?? 

?? 

?? 
 
??  大会员信息


?? 

?? 

?? 

??  直播信息


?? 

?? 

?? 
&
??  空间页跳转链接


?? 


?? 

?? 

??  挂件信息


?? 

?? 

?? 

??  认证名牌


?? 

?? 

?? 

?	?  用户等级


?	? 	

?	? 


?	? 

?
?  用户简介


?
? 


?
? 

?
? 

?? 


?? 	

?? 


?? 

?? 


?? 	

?? 


?? 
#
??  ?  直播头像样式


?? 

? ? 


? ? 


? ? 

? ? 

?? 


?? 


?? 

?? 

?? 


?? 


?? 

?? 

?? 


?? 


?? 

?? 

?? 


?? 


?? 

?? 

.?  ?! 用户类型


.? 

. ? "


. ? 

. ? 

.? "


.? 

.? 

.? #"


.? 

.? !"

.? "


.? 

.? 

.? "


.? 

.? 
#
??! ?! 头像挂件信息


??!

? ?! pid


? ?!	

? ?!


? ?!

??! 名称


??!


??!

??!

??! 图片链接


??!


??!

??!

??! 有效期


??!	

??!


??!

??! ?! 角标信息


??!

? ?! 文案


? ?!


? ?!

? ?!
$
??! 文案颜色-日间


??!


??!

??!
$
??!  文案颜色-夜间


??!


??!

??!
$
??! 背景颜色-日间


??!


??!

??!
$
??! 背景颜色-夜间


??!


??!

??!
$
??! 边框颜色-日间


??!


??!

??!
$
??!" 边框颜色-夜间


??!


??!

??! !

??! 样式


??!	

??!


??!
'
??! 背景透明度-日间


??!	

??!


??!
'
?	?! 背景透明度-夜间


?	?!	

?	?!


?	?!

/?! ?! 番剧类型


/?!

/ ?!" 没有子类型


/ ?!

/ ?!

/?!" 番剧


/?!

/?!

/?!" 电影


/?!

/?!

/?! " 纪录片


/?!

/?!

/?!" 国创


/?!

/?!

/?!" 电视剧


/?!

/?!

0?! ?! 视频类型


0?!

0 ?!"普通视频


0 ?!

0 ?!

0?!"动态视频


0?!

0?!
!
0?!"直播回放视频


0?!

0?!

0?!"


0?!

0?!
 
??! ?! 大会员信息


??!
 
? ?! 大会员类型


? ?!	

? ?!


? ?!
 
??! 大会员状态


??!	

??!


??!

??! 到期时间


??!	

??!


??!

??! 标签


??!

??!

??!

??! 主题


??!	

??!


??!
]
??!N 大会员角标
 0:无角标 1:粉色大会员角标 2:绿色小会员角标


??!	

??!


??!
G
??!8 昵称色值，可能为空，色值示例：#FFFB9E60


??!


??!

??!
 
??! ?! 大会员标签


??!

? ?! 图片地址


? ?!


? ?!

? ?!

??! 文本值


??!


??!

??!
#
??! 对应颜色类型


??!


??!

??!

1?! ?! 状态


1?!

1 ?!" 正常


1 ?!


1 ?!

1?!" 匿名


1?!

1?!

??! ?! 提权样式


??!
#
? ?! 提权展示标题


? ?!


? ?!

? ?!
 
??!" 下拉框内容


??!

??!

??!

??! !

??! icon


??!


??!

??!
)
??! ?! 热门默认跳转按钮


??!

? ?!

? ?!


? ?!

? ?!

??! 展示文案


??!


??!

??!
#
??! ?! 提权不感兴趣


??!
T
? ?!E 负反馈业务类型 作为客户端调用负反馈接口的参数


? ?!


? ?!

? ?!

??! 展示文案


??!


??!

??!

??! ?! 提权样式


??!

? ?! 类型


? ?!

? ?!

? ?!

? ?!?!

? ?!

)
??!  热门默认跳转按钮


??!

??!

??!
#
??!" 提权不感兴趣


??!

??!

??! !
#
2?" ?" 枚举-提权类型


2?"

2 ?"" 默认 占位


2 ?"

2 ?"

2?"" 不感兴趣


2?"

2?"

2?"" 跳链


2?"

2?"bproto3