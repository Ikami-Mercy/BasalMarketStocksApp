import 'package:data/di/injection.dart';
import 'package:dependencies/dependencies.dart';
import 'package:basal_test/di/injection.config.dart';



@injectableInit
Future<void> configureInjection(String environment) async {
  await configureDataInjection();
  $initGetIt(getIt, environment: environment);
}