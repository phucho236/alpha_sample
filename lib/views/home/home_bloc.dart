import 'package:alpha_sample/base/builder/base.dart';

class HomeBloc extends BaseBloc {
  HomeBloc() : super(DataLoadedState(data: DateTime.now()));

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) {
    return super.mapEventToState(event);
  }
}
