import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('bloc - onEvent: ${bloc.runtimeType} - $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc - onTransition: ${bloc.runtimeType} - $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('bloc - onError: ${cubit.runtimeType} - $error');
    super.onError(cubit, error, stackTrace);
  }
}
