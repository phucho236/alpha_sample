import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class SampleBuilderBloc extends BaseBloc {
  var repository = locator<UserRepository>();

  SampleBuilderBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is FetchDataEvent) {
      yield* _mapFetchDataLoaded();
    } else {
      yield* super.mapEventToState(event);
    }
  }

  Stream<BaseState> _mapFetchDataLoaded() async* {
    try {
      var _employees = await repository.fetchEmployees();
      yield DataLoadedState(data: _employees);
    } on DioError catch (e) {
      yield ErrorState(message: e.toString());
    }
  }
}
