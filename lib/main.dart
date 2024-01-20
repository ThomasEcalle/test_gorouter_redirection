import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorouter_test_persos/auth_bloc/auth_bloc.dart';

import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: AppRouter.router(
              authBloc: context.read<AuthBloc>(),
            ),
          );
        },
      ),
    );
  }
}
