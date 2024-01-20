import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test_persos/auth_bloc/auth_bloc.dart';

import '../fake_analytics_logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Login screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LoginScreen'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Fake login success'),
              onPressed: () => _fakeLoginSuccess(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('GoBack'),
              onPressed: () => _goBack(context),
            ),
          ],
        ),
      ),
    );
  }

  void _fakeLoginSuccess(BuildContext context) async {
    context.read<AuthBloc>().add(AuthenticateUser());
  }

  void _goBack(BuildContext context) {
    context.pop();
  }
}
