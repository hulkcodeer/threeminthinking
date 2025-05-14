import 'package:flutter/material.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayPlaceHolder,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
