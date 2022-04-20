import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grpc_chat_client/main.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';
import 'package:grpc_chat_client/src/cubit/app_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_incoming_cubit.dart';
import 'package:grpc_chat_client/src/cubit/message_send_cubit.dart';
import 'package:grpc_chat_client/src/pages/chat_room_page.dart';
import 'package:grpc_chat_client/src/pages/register_user_page.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                final hasRegister =
                    context.read<AppCubit>().state.username != null;

                if (!hasRegister) {
                  return const RegisterUserPage();
                }

                return const ChatRoomPage();
              },
            );
          },
        );
      },
    );
  }
}

class MyAppProviderWrapper extends StatelessWidget {
  const MyAppProviderWrapper({
    Key? key,
    required this.child,
    required this.grpcClient,
  }) : super(key: key);

  final Widget child;
  final ChatMessagingServiceClient grpcClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessageIncomingCubit(grpcClient: grpcClient),
        ),
        BlocProvider(
          create: (context) => MessageSendCubit(grpcClient: grpcClient),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: child,
    );
  }
}
