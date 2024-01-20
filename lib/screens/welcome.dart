import 'package:flutter/material.dart';
import 'package:gorouter_test_persos/fake_analytics_logger.dart';
import 'package:gorouter_test_persos/router.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Welcome screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () => _goToLogin(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go to Home'),
              onPressed: () => _goToHome(context),
            ),
          ],
        ),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    AppRouter.goToAuthenticationThenRedirect(
      context,
      loginRoute: AppRoute.loginFromWelcome,
      redirection: AppRoute.home,
    );
  }

  void _goToHome(BuildContext context) {
    AppRouter.go(AppRoute.home);
  }
}
