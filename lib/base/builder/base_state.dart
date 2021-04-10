import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
  @override
  List<Object> get props => [];
}

class InitialState extends BaseState {
  InitialState();

  @override
  String toString() => "InitialState";
}

class LoadingState extends BaseState {
  @override
  String toString() => 'LoadingState';
}

class DataLoadedState extends BaseState {
  final dynamic data;

  DataLoadedState({this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataLoadedState: $data';
}

class ErrorState extends BaseState {
  final dynamic message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message, DateTime.now()];

  @override
  String toString() => "Error: $message";
}

class LoadConfigState extends BaseState {
  final dynamic configs;
  final dynamic data;

  LoadConfigState(this.configs, this.data);

  @override
  List<dynamic> get props => [configs, data];

  @override
  String toString() => 'LoadConfigState';
}

class LoadMoreSuccessState extends BaseState {
  final List<PostModel> data;
  final bool hasReachedMax;

  const LoadMoreSuccessState({
    this.data,
    this.hasReachedMax,
  });

  LoadMoreSuccessState copyWith({
    List<BaseState> data,
    bool hasReachedMax,
  }) {
    return LoadMoreSuccessState(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data, hasReachedMax];

  @override
  String toString() =>
      'LoadMoreSuccessState { posts: ${data.length}, hasReachedMax: $hasReachedMax }';
}
