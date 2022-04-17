# GRPC Chat App with Flutter and Dart

There are several ways to make a chat app. For example you can make chat app using websocket or Firebase Realtime Database. Today i'm gonna show you how to make one with GRPC. If you don't have experience in GRPC, don't worry, it won't be as hard as you might think.

For this article we will make things as simple as possible. So you can follow along without worrying too much detail such as server authentication, testing, ui. etc. Therefore it's far from production ready app. Keep in mind this tutorial focus is to learn GRPC in Flutter and Dart.

There's a caveat though, i will use `flutter_bloc` for state mangement. which might be daunting for some people because of the boilerplate. if you use other state management solution, please go ahead. The reason why i choose `flutter_bloc` because it's what i'm comfortable with.

## Prerequisite

> - Flutter installed ( >= 2.10)
> - Dart installed ( >= 2.16.1)
> - pub bin is on PATH

## Create Directory

Okay, Let's begin.

In working directory run these commands.

### create new dart project for server

`` dart create -t console-simple grpc_server ``

### create new flutter app with skeleton template

`` flutter create -t skeleton --org=com.example.yourapp grpc_chat_client ``

### create new directory

`` mkdir proto ``

### The Structure

``` none
+---chat-grpc-tutorial                                                                                                  |   +---grpc_chat_client                                                                                                |   +---grpc_server 
|   +---proto
```

## Install Protoc / Protocol Buffer

To keep it simple, protocol buffer is the subtitute of JSON when we using REST.

you need to install `protoc` to generate from proto to dart

heads up to :

<https://grpc.io/docs/protoc-installation/>

or

<https://github.com/protocolbuffers/protobuf/releases>

## Create and Generate Chat Proto

``protoc -I=./proto --dart_out=grpc:lib/src/proto.gen chat.proto``

```protobuf
syntax = "proto3";

service ChatMessagingService {

    rpc Subscribe(SubscribeRequest) returns (stream MessageResponse);

    rpc SendMessage(MessageRequest) returns (Empty);

}

message Empty {

}

message MessageRequest {
    string username = 1;
    string message =2;
    string toChannel =3;
}

message SubscribeRequest {
    string channel = 1;
    string username = 2;
}

message MessageResponse {
    string fromUsername =1;
    string message =2;
    string fromChannel =3;
}
```

protobuf, just like it's name, it's only a protocol. we will define our logic later. but right now, our contract is clear. client can call `subscribe` and `sendMessage`.

## Dart GRPC Chat Broadcast Server

first cd to `grpc_server`

add these to pubspec.yaml

```
dependencies:
  grpc:
  protobuf:
  equatable:

```

``` dart
Future<void> main(List<String> args) async {
  final server = Server(
    [
      BookMethodsService(),
      ChatService(),
    ],
    const <Interceptor>[],
    CodecRegistry(codecs: const [
      GzipCodec(),
      IdentityCodec(),
    ]),
  );
  await server.serve(port: 54242);
  print('Server listening on port ${server.port}...');
}
```

``` dart
class TopicAndUser extends Equatable {
  final String topic;
  final String user;

  TopicAndUser({
    required this.topic,
    required this.user,
  });

  @override
  List<Object?> get props => [topic, user];
}

```

```dart
class ChatService extends ChatMessagingServiceBase {
  StreamController<MessageResponse> chatStream = StreamController.broadcast();
  Set<TopicAndUser> users = {};

  @override
  Future<Empty> sendMessage(ServiceCall call, MessageRequest request) async {
    print(request);
    final bool isExist = users.contains(
      TopicAndUser(topic: request.toChannel, user: request.username),
    );

    if (!isExist) return Empty();

    chatStream.sink.add(MessageResponse(
      message: request.message,
      fromUsername: request.username,
      fromChannel: request.toChannel,
    ));

    return Empty();
  }

  @override
  Stream<MessageResponse> subscribe(
    ServiceCall call,
    SubscribeRequest request,
  ) async* {
    users.add(TopicAndUser(topic: request.channel, user: request.username));

    await for (MessageResponse v in chatStream.stream) {
      if (request.channel == v.fromChannel) {
        yield MessageResponse(
          fromChannel: v.fromChannel,
          fromUsername: v.fromUsername,
          message: v.message,
        );
      }
    }
  }
}
```

## Flutter GRPC Chat Client

add this dependency to pubspec.yaml :

```yaml
flutter_bloc: ^8.0.1
equatable: ^2.0.3
hydrated_bloc: ^8.1.0
path_provider: ^2.0.9
grpc:
```

we will use hydrated_bloc to preserve state

add before main() :

```dart
import 'package:grpc/grpc.dart';


final channel = ClientChannel(
  EnvConfig.grpcAddress,
  port: EnvConfig.grpcPort,
  options: const ChannelOptions(
    credentials: ChannelCredentials.insecure(),
  ),
);

final ChatMessagingServiceClient grpcClient =
    ChatMessagingServiceClient(channel);
```

grpcClient will be used in connections we made.

we can call methods that are generated earlier, such as `subscribe` and `sendMessage`.

next, let's make a bloc. create new directory `cubit/message_incoming` and `cubit/message_send` in `lib/src/`

### message_incoming_cubit.dart

in directory message_incoming create new file `message_incoming_cubit.dart`

subscribeMesage has a method called subscribe. now, we want to listen to that subscription. Make a StreamSubscription and ResponseStream to manage stream listener.

```

```

### message_send_cubit.dart

in directory message_send create new file `mmessage_send_cubit.dart`

message_send_cubit is the cubit for sending message through grpc. it will call sendMessage using grpcClient.

```
```

## Conclusion

a simple chat app with multiple user is very easy to make with flutter and dart. at first, i was skeptical about to use dart as a server. when i read the docs, i was surprised how easy it is to implement grpc server using dart. there is no second thought in using go or rust, because dart is more familiar to me.
