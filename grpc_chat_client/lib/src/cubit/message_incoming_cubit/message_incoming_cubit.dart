import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_chat_client/proto/chat.pb.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MessageIncomingCubit extends HydratedCubit<MessageData> {
  MessageIncomingCubit({
    required this.grpcClient,
  }) : super(const MessageData());

  final ChatMessagingServiceClient grpcClient;

  StreamSubscription? chatSubscription;
  ResponseStream? responseStream;

  void subscribe(String channel, String username) async {
    responseStream ??= grpcClient.subscribe(SubscribeRequest());

    chatSubscription ??= responseStream?.listen((response) {
      _addToState(response);
    });
  }

  void _addToState(MessageResponse response) async {
    emit(MessageData(messages: [
      ...state.messages,
      ChatBubble(
        id: response.id,
        message: response.message,
        time: DateTime.fromMillisecondsSinceEpoch(response.dateEpoch.toInt()),
        username: response.fromUsername,
      )
    ]));
  }

  @override
  MessageData? fromJson(Map<String, dynamic> map) {
    final decoded = json.decode(map['messages']);

    return MessageData(
        messages: [for (var item in decoded) ChatBubble.fromJson(item)]);
  }

  @override
  Map<String, dynamic>? toJson(MessageData state) {
    return {
      'messages': json.encode([for (var item in state.messages) item.toJson()])
    };
  }
}

class MessageData extends Equatable {
  final List<ChatBubble> messages;

  const MessageData({this.messages = const []});

  @override
  List<Object?> get props => [
        messages,
      ];
}

class ChatBubble extends Equatable {
  final String id;
  final String message;
  final DateTime time;
  final String username;

  const ChatBubble({
    required this.id,
    required this.message,
    required this.time,
    required this.username,
  });

  Map toJson() {
    return {
      'id': id,
      'message': message,
      'time': time,
      'username': username,
    };
  }

  static fromJson(Map map) {
    ChatBubble(
      id: map['id'],
      message: map['message'],
      time: map['time'],
      username: map['username'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        message,
        time,
        username,
      ];
}
