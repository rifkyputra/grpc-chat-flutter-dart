import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final channel = ClientChannel(
  EnvConfig.grpcAddress,
  port: EnvConfig.grpcPort,
  options: const ChannelOptions(
    credentials: ChannelCredentials.insecure(),
  ),
);

final ChatMessagingServiceClient grpcClient =
    ChatMessagingServiceClient(channel);

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}

class EnvConfig {
  static const int grpcPort = int.fromEnvironment(
    'GRPC_PORT',
    defaultValue: 54242,
  );

  static const String grpcAddress = String.fromEnvironment(
    'GRPC_ADDR',
    defaultValue: 'localhost',
  );
}
