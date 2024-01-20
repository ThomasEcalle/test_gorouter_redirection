import 'dart:async';

import 'package:flutter/material.dart';

import 'auth_bloc/auth_bloc.dart';

class AuthStateNotifier extends ChangeNotifier {
  final AuthBloc authBloc;

  AuthStateNotifier({required this.authBloc}) {
    authBloc.stream.listen((event) {
      notifyListeners();
    });
  }
}
