import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const PrimaryButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 4.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
          backgroundColor: Colors.blue.shade100,
          // fixedSize: Size(double.infinity, 4.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
