import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MessageIncomingCubit extends HydratedCubit<MessageData> {
  MessageIncomingCubit({
    required this.grpcClient,
  }) : super(const MessageData());

  final ChatMessagingServiceClient grpcClient;

  StreamSubscription? _chatSubscription;
  ResponseStream? _responseStream;

  void subscribe(String username) async {
    _responseStream ??=
        grpcClient.subscribe(SubscribeRequest(username: username));

    _chatSubscription ??= _responseStream?.listen((response) {
      _addToState(response);
    });
  }

  void _addToState(MessageResponse response) async {
    emit(MessageData(messages: [
      ...state.messages,
      ChatMessage(
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
      messages: [for (var item in decoded) ChatMessage.fromJson(item)],
    );
  }

  @override
  Map<String, dynamic>? toJson(MessageData state) {
    return {
      'messages': json.encode([for (var item in state.messages) item.toJson()])
    };
  }
}

class MessageData extends Equatable {
  final List<ChatMessage> messages;

  const MessageData({this.messages = const []});

  @override
  List<Object?> get props => [
        messages,
      ];
}

class ChatMessage extends Equatable {
  final String id;
  final String message;
  final DateTime time;
  final String username;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.time,
    required this.username,
  });

  Map toJson() {
    return {
      'id': id,
      'message': message,
      'time': time.millisecondsSinceEpoch,
      'username': username,
    };
  }

  static fromJson(Map map) {
    return ChatMessage(
      id: map['id'],
      message: map['message'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
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
