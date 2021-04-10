import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationResetPassword extends AuthenticationState {
  final String email;
  final String token;

  AuthenticationResetPassword({this.email, this.token});

  @override
  List<Object> get props => [email, token];

  @override
  String toString() => "AuthenticationResetPassword: $email ${token.length}";
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "AuthenticationError: $message";
}
