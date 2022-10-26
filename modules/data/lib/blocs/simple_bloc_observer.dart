import 'package:dependencies/dependencies.dart';

/// Custom [BlocObserver] that observers all [Bloc] and [Cubit] instances
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Fimber.i('${bloc.runtimeType} $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Fimber.i('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    Fimber.i('${bloc.runtimeType} $error $stackTrace');
  }
}