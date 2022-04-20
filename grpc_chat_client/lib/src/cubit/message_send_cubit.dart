import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';

class MessageSendCubit extends Cubit<MessageSendState> {
  MessageSendCubit({
    required this.grpcClient,
  }) : super(MessageSendState.none);

  final ChatMessagingServiceClient grpcClient;

  void sendMessage(MessageRequest message) async {
    try {
      await grpcClient.sendMessage(message);
      emit(MessageSendState.success);
    } catch (e) {
      emit(MessageSendState.failed);
    }

    emit(MessageSendState.none);
  }
}

enum MessageSendState {
  success,
  failed,
  none,
}
