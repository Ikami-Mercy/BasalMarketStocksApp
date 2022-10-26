import 'dart:io';
import 'dart:isolate';

import 'package:data/di/injection.dart';

class InitServices {
  /// Init [Fimber] for logging
  void initLogger() {
    Fimber.plantTree(DebugTree());
  }

  /// Init DI with the respective environment
  Future<void> _initDI(String environment) async {
    await configureInjection(environment);
  }

  /// Load respective environment
  Future initEnv(bool isProd) async {
    try {
      await dotenv.load(fileName: Assets.ENV_PRODUCTION);
      await _initDI(Env.production);
      await getIt<RemoteConfig>().setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(seconds: 30),
          minimumFetchInterval: Duration(seconds: 30),
        ),
      );
      await getIt<RemoteConfig>().fetchAndActivate();
    } catch (e) {
      Fimber.e('Env Initialization failed: $e', ex: e);
    }
  }
}
