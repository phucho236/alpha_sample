import 'package:alpha_sample/models/internal/config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialState extends AppState {
  @override
  String toString() => "AppInitialState";
}

class ShowLoadingState extends AppState {
  final BuildContext context;

  ShowLoadingState(this.context);

  @override
  String toString() => 'ShowLoadingState ${context.runtimeType}';
}

class DismissLoadingState extends AppState {
  final BuildContext context;

  DismissLoadingState(this.context);

  @override
  String toString() => 'DismissLoadingState ${context.runtimeType}';
}

class UpdateConfigState extends AppState {
  final bool isChange;
  final Config config;

  UpdateConfigState(this.isChange, this.config);

  @override
  List<Object> get props => [isChange, config];

  @override
  String toString() => 'UpdateConfigState';
}