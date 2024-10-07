import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:threeminthinking/screens/splash.dart';
// 여기에 필요한 화면들을 import 합니다

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
