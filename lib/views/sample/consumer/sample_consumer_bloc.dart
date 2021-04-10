import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class SampleConsumerBloc extends BaseBloc {
  var repository = locator<UserRepository>();

  SampleConsumerBloc() : super(DataLoadedState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is FetchEmployeesEvent) {
      yield* _mapFetchEmployees();
    }


  }

  Stream<BaseState> _mapFetchEmployees() async* {
    try {
      var _employees = await repository.fetchEmployees();
      yield FetchEmployeesState(data: _employees);
    } on DioError catch (e) {
      yield ErrorState(message: e.toString());
    }
  }
}

class FetchEmployeesEvent extends BaseEvent {
  @override
  String toString() => 'FetchEmployeesEvent';
}

class FetchEmployeesState extends BaseState {
  final dynamic data;

  FetchEmployeesState({this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FetchEmployeesState';
}
