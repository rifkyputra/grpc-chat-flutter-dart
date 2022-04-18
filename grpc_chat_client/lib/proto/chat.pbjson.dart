///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use messageRequestDescriptor instead')
const MessageRequest$json = const {
  '1': 'MessageRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'toChannel', '3': 3, '4': 1, '5': 9, '10': 'toChannel'},
  ],
};

/// Descriptor for `MessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageRequestDescriptor = $convert.base64Decode('Cg5NZXNzYWdlUmVxdWVzdBIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWUSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIcCgl0b0NoYW5uZWwYAyABKAlSCXRvQ2hhbm5lbA==');
@$core.Deprecated('Use subscribeRequestDescriptor instead')
const SubscribeRequest$json = const {
  '1': 'SubscribeRequest',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 9, '10': 'channel'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `SubscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeRequestDescriptor = $convert.base64Decode('ChBTdWJzY3JpYmVSZXF1ZXN0EhgKB2NoYW5uZWwYASABKAlSB2NoYW5uZWwSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW1l');
@$core.Deprecated('Use messageResponseDescriptor instead')
const MessageResponse$json = const {
  '1': 'MessageResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'fromUsername', '3': 2, '4': 1, '5': 9, '10': 'fromUsername'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'fromChannel', '3': 4, '4': 1, '5': 9, '10': 'fromChannel'},
    const {'1': 'dateEpoch', '3': 5, '4': 1, '5': 3, '10': 'dateEpoch'},
  ],
};

/// Descriptor for `MessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageResponseDescriptor = $convert.base64Decode('Cg9NZXNzYWdlUmVzcG9uc2USDgoCaWQYASABKAlSAmlkEiIKDGZyb21Vc2VybmFtZRgCIAEoCVIMZnJvbVVzZXJuYW1lEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USIAoLZnJvbUNoYW5uZWwYBCABKAlSC2Zyb21DaGFubmVsEhwKCWRhdGVFcG9jaBgFIAEoA1IJZGF0ZUVwb2No');
