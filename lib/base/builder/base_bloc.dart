import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(BaseState initialState) : super(initialState);
  @override
  Stream<Transition<BaseEvent, BaseState>> transformEvents(
    Stream<BaseEvent> events,
    TransitionFunction<BaseEvent, BaseState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    final currentState = state;
    if (event is FetchDataEvent && !_hasReachedMax(currentState)) {
      yield DataLoadedState();
    } else if (event is ErrorEvent) {
      yield ErrorState(message: event.error);
    }
  }
}

bool _hasReachedMax(BaseState state) =>
    state is LoadMoreSuccessState && state.hasReachedMax;
