import 'package:go_router/go_router.dart';
import 'package:threeminthinking/screens/history_screen.dart';

import 'package:threeminthinking/screens/home_screen.dart';
import 'package:threeminthinking/screens/splash_screen.dart';
import 'package:threeminthinking/screens/think3min_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/think3min',
      builder: (context, state) => Think3minScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) {
        final date = state.uri.queryParameters['date'] ?? "";
        return HistoryScreen(date: date);
      },
    ),
  ],
);
