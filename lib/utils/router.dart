import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:threeminthinking/screens/home_screen.dart';
import 'package:threeminthinking/screens/splash_screen.dart';

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
    // GoRoute(
    //   path: '/history',
    //   builder: (context, state) {
    //     final date = state.queryParams['date'];
    //     return HistoryScreen(date: date);
    //   },
    // ),
  ],
);
