import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<CheckAuthStatus>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    });

    on<AuthenticateUser>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.authenticated));
    });

    on<UnauthenticateUser>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    });
  }
}
