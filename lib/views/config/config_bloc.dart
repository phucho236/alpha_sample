import 'package:alpha_sample/base/builder/base.dart';

class ConfigBloc extends BaseBloc{
  ConfigBloc() : super(DataLoadedState(data: DateTime.now()));
}