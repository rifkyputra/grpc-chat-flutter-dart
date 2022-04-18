///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
export 'chat.pb.dart';

class ChatMessagingServiceClient extends $grpc.Client {
  static final _$subscribe =
      $grpc.ClientMethod<$0.SubscribeRequest, $0.MessageResponse>(
          '/ChatMessagingService/Subscribe',
          ($0.SubscribeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MessageResponse.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$0.MessageRequest, $0.Empty>(
      '/ChatMessagingService/SendMessage',
      ($0.MessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  ChatMessagingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.MessageResponse> subscribe(
      $0.SubscribeRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Empty> sendMessage($0.MessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }
}

abstract class ChatMessagingServiceBase extends $grpc.Service {
  $core.String get $name => 'ChatMessagingService';

  ChatMessagingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubscribeRequest, $0.MessageResponse>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SubscribeRequest.fromBuffer(value),
        ($0.MessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageRequest, $0.Empty>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$0.MessageResponse> subscribe_Pre($grpc.ServiceCall call,
      $async.Future<$0.SubscribeRequest> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.Empty> sendMessage_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Stream<$0.MessageResponse> subscribe(
      $grpc.ServiceCall call, $0.SubscribeRequest request);
  $async.Future<$0.Empty> sendMessage(
      $grpc.ServiceCall call, $0.MessageRequest request);
}
