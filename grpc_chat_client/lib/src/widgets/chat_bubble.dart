import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_chat_client/src/cubit/app_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_incoming_cubit.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.messageData,
    this.isSender = false,
  }) : super(key: key);

  final ChatMessage messageData;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Align(
          alignment: isSender ? Alignment.topRight : Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${messageData.time.hour} :${messageData.time.minute}',
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(isSender ? 'Me' : messageData.username,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.grey.shade400)),
                const SizedBox(height: 8),
                Text(
                  messageData.message,
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
