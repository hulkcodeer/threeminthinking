import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/features/splash/presentation/viewmodels/splash_state.dart';
import 'package:threeminthinking/features/splash/presentation/viewmodels/splash_viewmodel.dart';

import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initialize();

      ref.listen<AsyncValue<SplashState>>(splashViewModelProvider, (_, state) {
        state.whenData((data) {
          data.whenOrNull(
            authenticated: () {
              context.go('/makeVocabulary');
            },
            unauthenticated: () {
              Timer(const Duration(seconds: 1), () {
                if (mounted) {
                  context.go('/makeVocabulary');
                }
              });
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        });
      });
    });
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    ref.read(splashViewModelProvider.notifier).checkUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset('assets/images/splash_center_logo.svg'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: SvgPicture.asset('assets/images/mixdrops_logo.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
