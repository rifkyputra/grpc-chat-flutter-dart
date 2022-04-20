import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_chat_client/proto/chat.pbgrpc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  final channel = ClientChannel(
    EnvConfig.grpcAddress,
    port: EnvConfig.grpcPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final ChatMessagingServiceClient grpcClient =
      ChatMessagingServiceClient(channel);

  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyAppProviderWrapper(
        grpcClient: grpcClient,
        child: MyApp(
          settingsController: settingsController,
        ),
      ),
    ),
    storage: storage,
  );
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
