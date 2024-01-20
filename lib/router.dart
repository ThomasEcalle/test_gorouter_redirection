import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_test_persos/auth_bloc/auth_bloc.dart';
import 'package:gorouter_test_persos/auth_state_notifier.dart';
import 'package:gorouter_test_persos/screens/home_screen.dart';
import 'package:gorouter_test_persos/screens/login_screen.dart';
import 'package:gorouter_test_persos/screens/profile_screen.dart';
import 'package:gorouter_test_persos/screens/protected_screen.dart';
import 'package:gorouter_test_persos/screens/splash.dart';
import 'package:gorouter_test_persos/screens/welcome.dart';

enum AppRoute {
  splash._('splash', '/splash', '/splash'),
  home._('home', '/home', '/home'),
  loginFromHome._('homeLogin', 'login', '/home/login'),
  welcome._('welcome', '/welcome', '/welcome'),
  loginFromWelcome._('welcomeLogin', 'login', '/welcome/login'),
  profile._('profile', 'profile', '/home/profile'),
  protected._('protected', 'protected', '/home/protected'),
  loginFromProtectedFeature._('protectedFeatureLogin', 'login', '/home/profile/login');

  final String name;
  final String path;
  final String fullPath;

  const AppRoute._(
    this.name,
    this.path,
    this.fullPath,
  );
}

class AppRouter {
  AppRouter._();

  static GoRouter? _instance;

  static String? _targetedLocation;

  static GoRouter router({required AuthBloc authBloc}) {
    return _instance ??= GoRouter(
      initialLocation: AppRoute.splash.path,
      routes: [
        GoRoute(
          path: AppRoute.splash.path,
          pageBuilder: (context, state) => _buildCustomTransitionPage(const Splash()),
        ),
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          pageBuilder: (context, state) => _buildCustomTransitionPage(const HomeScreen()),
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              name: AppRoute.profile.name,
              pageBuilder: (context, state) => _buildCustomTransitionPage(const ProfileScreen()),
              routes: [
                GoRoute(
                  path: AppRoute.loginFromProtectedFeature.path,
                  name: AppRoute.loginFromProtectedFeature.name,
                  pageBuilder: (context, state) => _buildCustomTransitionPage(const LoginScreen()),
                ),
              ],
            ),
            GoRoute(
              path: AppRoute.protected.path,
              name: AppRoute.protected.name,
              pageBuilder: (context, state) => _buildCustomTransitionPage(const ProtectedScreen()),
            ),
            GoRoute(
              path: AppRoute.loginFromHome.path,
              name: AppRoute.loginFromHome.name,
              pageBuilder: (context, state) => _buildCustomTransitionPage(const LoginScreen()),
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.welcome.path,
          name: AppRoute.welcome.name,
          pageBuilder: (context, state) => _buildCustomTransitionPage(const Welcome()),
          routes: [
            GoRoute(
              path: AppRoute.loginFromWelcome.path,
              name: AppRoute.loginFromWelcome.name,
              pageBuilder: (context, state) => _buildCustomTransitionPage(const LoginScreen()),
            ),
          ],
        ),
      ],
      refreshListenable: AuthStateNotifier(authBloc: authBloc),
      redirect: (context, state) {
        final authBloc = context.read<AuthBloc>();
        final authUserStatus = authBloc.state.status;
        final matchedLocation = state.matchedLocation;

        switch (authUserStatus) {
          case AuthStatus.unknown:
            return AppRoute.splash.fullPath;
          case AuthStatus.authenticated:
            if (_targetedLocation != null) {
              final target = _targetedLocation;
              _targetedLocation = null;
              return target;
            }
            if (matchedLocation == AppRoute.home.fullPath) return null;
            return null;
          case AuthStatus.unauthenticated:
            if (matchedLocation == AppRoute.protected.fullPath) {
              _targetedLocation = AppRoute.protected.fullPath;
              return AppRoute.loginFromHome.fullPath;
            }
            if (matchedLocation == AppRoute.splash.path) return AppRoute.welcome.fullPath;
            return null;
        }
      },
    );
  }

  static CustomTransitionPage _buildCustomTransitionPage(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static void go(AppRoute route) {
    _instance?.goNamed(route.name);
  }

  static void goToAuthenticationThenRedirect(
    BuildContext context, {
    required AppRoute loginRoute,
    required AppRoute redirection,
  }) {
    _targetedLocation = redirection.fullPath;
    _instance?.goNamed(loginRoute.name);
  }
}
