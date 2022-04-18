import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';

class MessageSendCubit extends Cubit<MessageSendState> {
  MessageSendCubit({
    required this.grpcClient,
  }) : super(MessageSendState());

  final ChatMessagingServiceClient grpcClient;

  void sendMessage(MessageRequest message) async {
    await grpcClient.sendMessage(message);
  }
}

class MessageSendState {}
