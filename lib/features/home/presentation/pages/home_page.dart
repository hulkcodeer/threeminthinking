import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/core/uitils/fonts.dart';

class HomePage extends ConsumerStatefulWidget {
  final Widget child;

  const HomePage({required this.child, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with WidgetsBindingObserver, RouteAware {
  @override
  Widget build(BuildContext context) {
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
      // bottomNavigationBar: Container(
      //   decoration: const ShapeDecoration(
      //     color: Colors.white,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(16),
      //         topRight: Radius.circular(16),
      //       ),
      //       side: BorderSide(
      //         color: AppColors.grayLineSplit,
      //         width: 1,
      //       ),
      //     ),
      //   ),
      //   // child: Padding(
      //   //   padding: const EdgeInsets.only(
      //   //     left: 24,
      //   //     right: 24,
      //   //     top: 12,
      //   //     bottom: 36,
      //   //   ),
      //   //   child: Row(
      //   //     spacing: 14,
      //   //     mainAxisAlignment: MainAxisAlignment.center,
      //   //     children: [
      //   //       _buildMenuItem(
      //   //         unselectedAssetName: 'assets/images/ic_we_unselected.svg',
      //   //         selectedAssetName: 'assets/images/ic_we_selected.svg',
      //   //         isSelected: homeState.value?.selectedMenu == MenuType.weTodo,
      //   //         label: '우리의 할일',
      //   //         onTap: () {
      //   //           context.go('/home');
      //   //           ref.read(homeViewModelProvider.notifier).getWeTodos(homeState.value?.isTodaySelected ?? false);
      //   //         },
      //   //       ),
      //   //       _buildMenuItem(
      //   //         unselectedAssetName: 'assets/images/ic_me_unselected_30_24.svg',
      //   //         selectedAssetName: 'assets/images/ic_me_selected_30_24.svg',
      //   //         isSelected: homeState.value?.selectedMenu == MenuType.myTodo,
      //   //         label: '나의 할일',
      //   //         onTap: () {
      //   //           context.go('/home');
      //   //           ref.read(homeViewModelProvider.notifier).getMyTodos(homeState.value?.isTodaySelected ?? false);
      //   //         },
      //   //       ),
      //   //       if (homeState.value?.isSubscribed ?? false)
      //   //         _buildMenuItem(
      //   //           unselectedAssetName: 'assets/images/ic_shop_unselected_30_24.svg',
      //   //           selectedAssetName: 'assets/images/ic_shop_selected_30_24.svg',
      //   //           isSelected: homeState.value?.selectedMenu == MenuType.shopping,
      //   //           label: '살 것',
      //   //           onTap: () {
      //   //             if (homeState.value?.selectedMenu != MenuType.shopping) {
      //   //               ref.read(homeViewModelProvider.notifier).updateSelectedMenu(MenuType.shopping);
      //   //               context.push('/shoppingCart');
      //   //             }
      //   //           },
      //   //         ),
      //   //       if (homeState.value?.isSubscribed ?? false)
      //   //         _buildMenuItem(
      //   //           unselectedAssetName: 'assets/images/ic_meal_unselected_30_24.svg',
      //   //           selectedAssetName: 'assets/images/ic_meal_selected_30_24.svg',
      //   //           isSelected: homeState.value?.selectedMenu == MenuType.meal,
      //   //           label: '식단표',
      //   //           onTap: () {
      //   //             if (homeState.value?.selectedMenu != MenuType.meal) {
      //   //               ref.read(homeViewModelProvider.notifier).updateSelectedMenu(MenuType.meal);
      //   //               context.push('/mealPlan');
      //   //             }
      //   //           },
      //   //         ),
      //   //     ],
      //   //   ),
      //   // ),
      // ),
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
            SvgPicture.asset(
              isSelected ? selectedAssetName : unselectedAssetName,
            ),
            const SizedBox(height: 4),
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
