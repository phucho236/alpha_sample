import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ErrorEvent extends BaseEvent {
  final dynamic error;

  ErrorEvent({this.error});

  @override
  List<dynamic> get props => [error];

  @override
  String toString() => 'ErrorEvent ${error.toString()}';
}

class FetchDataEvent extends BaseEvent {
  final dynamic param;

  FetchDataEvent({this.param});

  @override
  List<dynamic> get props => [param];

  @override
  String toString() => 'FetchDataEvent $param';
}

class LoadMoreEvent extends FetchDataEvent {
  LoadMoreEvent({dynamic param}) : super(param: param);
  @override
  String toString() => 'LoadMoreEvent';
}

class LoadConfigEvent extends BaseEvent {
  final dynamic configs;

  LoadConfigEvent(this.configs);

  @override
  List<dynamic> get props => [configs];

  @override
  String toString() => 'LoadConfigEvent ${configs.toString()}';
}
