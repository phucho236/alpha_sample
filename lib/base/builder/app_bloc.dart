import 'package:alpha_sample/base/builder/app_event.dart';
import 'package:alpha_sample/base/builder/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitialState());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is UpdateConfigEvent)
      yield UpdateConfigState(event.isChange, event.config);

    if (event is ShowLoadingEvent) yield ShowLoadingState(event.context);

    if (event is DismissLoadingEvent) yield DismissLoadingState(event.context);
  }
}
