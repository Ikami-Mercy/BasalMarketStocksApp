import 'package:basal_test/di/injection.dart';
import 'package:basal_test/utils/resources/assets.dart';
import 'package:dependencies/dependencies.dart';

import 'di/environment.dart';

class InitServices {
  /// Init [Fimber] for logging
  void initLogger() {
    Fimber.plantTree(DebugTree());
  }

  /// Init DI with the respective environment
  Future<void> _initDI(String environment) async {
    Fimber.i('_initDI is called!');
    await configureInjection(environment);
  }

  /// Load respective environment
  Future initEnv(bool isProd) async {
    try {
      if (isProd) {
        await dotenv.load(fileName: Assets.ENV_PRODUCTION);
        await _initDI(Env.production);
      } else {
        await dotenv.load(fileName: Assets.ENV_TESTING);
        await _initDI(Env.test);
      }
    } catch (e) {
      Fimber.e('Env Initialization failed: $e', ex: e);
    }
  }
}
