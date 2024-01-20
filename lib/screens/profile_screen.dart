import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_bloc/auth_bloc.dart';
import '../fake_analytics_logger.dart';
import '../router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Profile screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ProfileScreen'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('protected feature'),
              onPressed: () => _onProtectedFeatureTap(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onProtectedFeatureTap(BuildContext context) {
    final isUserAuthenticated = context.read<AuthBloc>().state.status == AuthStatus.authenticated;
    if (isUserAuthenticated) {
      _showFeaturedDialog(context);
      return;
    }

    AppRouter.goToAuthenticationThenRedirect(
      context,
      loginRoute: AppRoute.loginFromProtectedFeature,
      redirection: AppRoute.profile,
    );
  }

  void _showFeaturedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Protected feature'),
          content: const Text('This is a protected feature'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
