part of 'auth_bloc.dart';

abstract class AuthEvent {}

/// THIS EVENT FOR USER SIGNIN
class UserLoginEvent extends AuthEvent{
  final String email;
  final String password;

  UserLoginEvent({required this.email, required this.password});
}

/// THIS EVENT FOR GET APP VERSION
class FetchAppVersionEvent extends AuthEvent{}