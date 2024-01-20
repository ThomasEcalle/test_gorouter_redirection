import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorouter_test_persos/auth_bloc/auth_bloc.dart';
import 'package:gorouter_test_persos/fake_analytics_logger.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Splash screen');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthBloc>().add(CheckAuthStatus());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
