import 'package:alpha_sample/models/internal/config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowLoadingEvent extends AppEvent {
  final BuildContext context;

  ShowLoadingEvent(this.context);

  @override
  String toString() => 'ShowLoadingEvent ${context.runtimeType}';
}

class DismissLoadingEvent extends AppEvent {
  final BuildContext context;

  DismissLoadingEvent(this.context);

  @override
  String toString() => 'DismissLoadingEvent ${context.runtimeType}';
}

class UpdateConfigEvent extends AppEvent {
  final bool isChange;
  final Config config;

  UpdateConfigEvent(this.isChange, this.config);

  @override
  List<Object> get props => [isChange, config];

  @override
  String toString() => 'UpdateConfigEvent';
}
