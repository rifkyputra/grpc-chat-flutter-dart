import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:grpc_server/proto/chat.pbgrpc.dart';
import 'package:uuid/uuid.dart';
import 'package:fixnum/fixnum.dart' as fn;

Future<void> main() async {
  final server = Server(
    [ChatService()],
    const <Interceptor>[],
    CodecRegistry(
      codecs: const [
        GzipCodec(),
        IdentityCodec(),
      ],
    ),
  );

  await server.serve(port: 54242);

  print('Server listening on port ${server.port}...');
}

class ChatService extends ChatMessagingServiceBase {
  StreamController<MessageRequest> chatStream = StreamController.broadcast();
  Set<String> users = {};

  @override
  Future<Empty> sendMessage(
    ServiceCall call,
    MessageRequest request,
  ) async {
    print(request.message);
    if (users.contains(request.username)) {
      chatStream.sink.add(request);
    }

    return Empty();
  }

  @override
  Stream<MessageResponse> subscribe(
    ServiceCall call,
    SubscribeRequest request,
  ) async* {
    users.add(request.username);

    await for (MessageRequest res in chatStream.stream) {
      yield (MessageResponse(
        id: Uuid().v4(),
        fromUsername: res.username,
        message: res.message,
        dateEpoch: fn.Int64(DateTime.now().millisecondsSinceEpoch),
      ));
    }
  }
}
