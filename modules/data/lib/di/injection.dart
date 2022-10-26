
import 'package:data/di/injection.config.dart';
import 'package:dependencies/dependencies.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: r'$initDataGetIt')
Future<void> configureDataInjection() async {
  await $initDataGetIt(getIt);
}