import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_chat_client/proto/chat.pb.dart';
import 'package:grpc_chat_client/src/cubit/app_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_incoming_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_send_cubit.dart';
import 'package:grpc_chat_client/src/widgets/chat_bubble.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  static const routeName = 'ChatRoomPage';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  void initState() {
    super.initState();

    context.read<MessageIncomingCubit>().subscribe(
          context.read<AppCubit>().state.username!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageSendCubit, MessageSendState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text('#general'),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade400,
                  child: BlocBuilder<MessageIncomingCubit, MessageData>(
                    builder: (context, state) {
                      final chats = state.messages.reversed.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: ChatBubble(
                              isSender: chats[index].username ==
                                  context.read<AppCubit>().state.username,
                              messageData: chats[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(color: Colors.grey.shade500),
                child: TextMessageField(),
              )
            ]),
      ),
    );
  }
}

class TextMessageField extends StatefulWidget {
  const TextMessageField({
    Key? key,
  }) : super(key: key);

  @override
  State<TextMessageField> createState() => _TextMessageFieldState();
}

class _TextMessageFieldState extends State<TextMessageField> {
  late final TextEditingController controller;

  String text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add_circle_outline_sharp),
          onPressed: () {
            //
          },
        ),
        Expanded(
          child: Container(
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                // fillColor: Colors.black,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onEditingComplete: () => _sendMessage(context),
              onChanged: (valuek) {
                setState(() {
                  text = valuek;
                });
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => _sendMessage(context),
        ),
      ],
    );
  }

  _sendMessage(BuildContext context) {
    if (controller.text.isEmpty) return;
    context.read<MessageSendCubit>().sendMessage(
          MessageRequest(
            username: context.read<AppCubit>().state.username,
            message: controller.text,
          ),
        );

    controller.clear();
    setState(() {
      text = '';
    });
  }
}
