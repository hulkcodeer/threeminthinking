import 'package:flutter/material.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';

class CommonPopup extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String? cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CommonPopup({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    this.cancelButtonText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              message,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cancelButtonText != null
                    ? Expanded(
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            backgroundColor: AppColors.grayUnselected,
                          ),
                          onPressed: onCancel,
                          child: Text(cancelButtonText ?? ""),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: onConfirm,
                    child: Text(confirmButtonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
