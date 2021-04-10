import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SamplePagingBloc extends BaseBloc {
  var repository = locator<UserRepository>();
  int start = 0;
  SamplePagingBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is LoadMoreEvent) {
      start = start + 4;
      yield* _mapLoadMoreDataLoaded(start);
    } else if (event is FetchDataEvent) {
      yield* _mapFetchDataLoaded();
    } else {
      yield* super.mapEventToState(event);
    }
  }

  Stream<BaseState> _mapFetchDataLoaded() async* {
    try {
      var _listPostModel = await repository.fetchEmployees(start: 0);
      yield DataLoadedState(data: _listPostModel);
    } on DioError catch (e) {
      yield ErrorState(message: e.toString());
    }
  }

  Stream<BaseState> _mapLoadMoreDataLoaded(int start) async* {
    final currentState = state;

    try {
      var _employees = await repository.fetchEmployees(start: start);
      yield _employees.isEmpty
          ? currentState is LoadMoreSuccessState
              ? currentState.copyWith(hasReachedMax: true)
              : LoadMoreSuccessState(data: _employees, hasReachedMax: false)
          : LoadMoreSuccessState(data: _employees, hasReachedMax: false);
    } on DioError catch (e) {
      yield ErrorState(message: e.toString());
    }
  }
}
