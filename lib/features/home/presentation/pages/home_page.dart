import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/core/uitils/fonts.dart';
import 'package:threeminthinking/features/home/presentation/viewmodels/home_state.dart';
import 'package:threeminthinking/features/home/presentation/viewmodels/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  final Widget child;

  const HomePage({required this.child, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.grayBg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: widget.child),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            side: BorderSide(
              color: AppColors.grayLineSplit,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,
            bottom: 36,
          ),
          child: Row(
            spacing: 14,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuItem(
                unselectedAssetName: '',
                selectedAssetName: '',
                isSelected: homeState.value?.selectedMenu == MenuType.wordbook,
                label: '단어장',
                onTap: () {
                  context.go('/home');
                },
              ),
              _buildMenuItem(
                unselectedAssetName: '',
                selectedAssetName: '',
                isSelected: homeState.value?.selectedMenu == MenuType.calendar,
                label: '캘린더',
                onTap: () {
                  context.go('/calendar');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String selectedAssetName,
    required String unselectedAssetName,
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SvgPicture.asset(
            //   isSelected ? selectedAssetName : unselectedAssetName,
            // ),
            // const SizedBox(height: 4),
            Text(
              label,
              style: AppFonts.bold12.copyWith(
                color: isSelected ? AppColors.primary : AppColors.grayUnselected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
