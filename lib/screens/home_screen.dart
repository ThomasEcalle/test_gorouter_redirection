import 'package:flutter/material.dart';
import 'package:gorouter_test_persos/router.dart';

import '../fake_analytics_logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Home screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomeScreen'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go to protected screen'),
              onPressed: () => _goToProtectedScreen(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go to profile screen'),
              onPressed: () => _goToProfileScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  void _goToProtectedScreen(BuildContext context) {
    AppRouter.go(AppRoute.protected);
  }

  void _goToProfileScreen(BuildContext context) {
    AppRouter.go(AppRoute.profile);
  }
}
