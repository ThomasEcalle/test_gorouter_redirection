part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class AuthenticateUser extends AuthEvent {}

class UnauthenticateUser extends AuthEvent {}
