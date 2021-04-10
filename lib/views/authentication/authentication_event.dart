import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String tokenItem;

  const LoggedIn({@required this.tokenItem});

  @override
  List<Object> get props => [tokenItem];

  @override
  String toString() => 'LoggedIn: token - ${tokenItem.length}';
}

class LoggedOut extends AuthenticationEvent {}

class ResetPassword extends AuthenticationEvent {
  final String email;
  final String token;

  ResetPassword({this.email, this.token});

  @override
  List<Object> get props => [email, token];

  @override
  String toString() => "ResetPassword: $email ${token.length}";
}