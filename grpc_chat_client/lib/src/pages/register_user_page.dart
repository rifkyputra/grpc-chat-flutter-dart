import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_chat_client/src/cubit/app_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_send_cubit.dart';
import 'package:grpc_chat_client/src/pages/chat_room_page.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  static const String routeName = 'RegisterUserPage';

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final TextEditingController textEditingController = TextEditingController();

  String username = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state.username != null) {
          Navigator.of(context).pushNamed(ChatRoomPage.routeName);
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter Username',
              ),
              onChanged: (value) => setState(() => username = value),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.read<AppCubit>().saveUsername(username),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
