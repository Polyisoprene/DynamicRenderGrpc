# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: bilibili/rpc/status.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database

# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import any_pb2 as google_dot_protobuf_dot_any__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(
    b'\n\x19\x62ilibili/rpc/status.proto\x12\x0c\x62ilibili.rpc\x1a\x19google/protobuf/any.proto"N\n\x06Status\x12\x0c\n\x04\x63ode\x18\x01 \x01(\x05\x12\x0f\n\x07message\x18\x02 \x01(\t\x12%\n\x07\x64\x65tails\x18\x03 \x03(\x0b\x32\x14.google.protobuf.Anyb\x06proto3'
)


_STATUS = DESCRIPTOR.message_types_by_name["Status"]
Status = _reflection.GeneratedProtocolMessageType(
    "Status",
    (_message.Message,),
    {
        "DESCRIPTOR": _STATUS,
        "__module__": "bilibili.rpc.status_pb2"
        # @@protoc_insertion_point(class_scope:bilibili.rpc.Status)
    },
)
_sym_db.RegisterMessage(Status)

if _descriptor._USE_C_DESCRIPTORS == False:

    DESCRIPTOR._options = None
    _STATUS._serialized_start = 70
    _STATUS._serialized_end = 148
# @@protoc_insertion_point(module_scope)