import 'package:data/di/injection.dart';
import 'package:dependencies/dependencies.dart';
import 'package:basal_test/di/injection.config.dart';

@injectableInit
Future<void> configureInjection(String environment) async {
  Fimber.i('configureInjection is called!');
  await configureDataInjection();
  $initGetIt(getIt, environment: environment);
}