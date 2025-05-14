import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/core/uitils/fonts.dart';

enum LeftButtonType {
  none, // 왼쪽 버튼 없음
  back, // 뒤로가기 버튼
  close, // 닫기 버튼
  add, // 추가 버튼
}

enum RightButtonType {
  none, // 오른쪽 버튼 없음
  close, // 닫기 버튼
  complete, // 완료 버튼
  feedback, // 피드백 버튼
  save, // 저장 버튼
}

class CustomNavigationHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavigationHeader(
    this.title, {
    super.key,
    this.rightButtonType = RightButtonType.none,
    this.leftButtonType = LeftButtonType.none,
    this.leftButtonOnTap,
    this.rightButtonTap,
  });

  final String title;
  final RightButtonType rightButtonType;
  final LeftButtonType leftButtonType;
  final Function()? rightButtonTap;
  final Function()? leftButtonOnTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      leading: leftButtonType == LeftButtonType.back
          ? IconButton(
              icon: SvgPicture.asset('assets/images/ic_navBack.svg'),
              onPressed: leftButtonOnTap ?? () => context.pop(),
            )
          : leftButtonType == LeftButtonType.close
              ? IconButton(
                  icon: SvgPicture.asset('assets/icons/ic_close_40_40.svg'),
                  onPressed: () => context.pop(),
                )
              : leftButtonType == LeftButtonType.add
                  ? IconButton(
                      icon: SvgPicture.asset('assets/icons/ic_add_40_40.svg'),
                      onPressed: leftButtonOnTap ?? () => context.push('/secret-code/add'),
                    )
                  : null,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: AppFonts.medium18.copyWith(color: AppColors.black),
      ),
      actions: [
        if (rightButtonType == RightButtonType.close)
          IconButton(
            icon: SvgPicture.asset('assets/icons/ic_close_40_40.svg'),
            onPressed: rightButtonTap ?? () => context.go("/"),
          )
        else if (rightButtonType == RightButtonType.feedback)
          TextButton(
            onPressed: rightButtonTap,
            child: Text(
              '보내기',
              style: AppFonts.bold15.copyWith(color: AppColors.primary),
            ),
          )
        else if (rightButtonType == RightButtonType.save)
          TextButton(
            onPressed: rightButtonTap,
            child: Text(
              '저장',
              style: AppFonts.bold15.copyWith(color: AppColors.primary),
            ),
          )
      ],
      toolbarHeight: 48,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
