import 'package:flutter/material.dart';

int _touchWellProtectedMultiTapTimeMs = 0;

class TouchWell extends StatelessWidget {
  final Widget child;
  final bool protectMultiTap;
  final Function()? onTap;

  const TouchWell({
    Key? key,
    this.protectMultiTap = true,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: protectMultiTap ? onTap != null ? () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if(now - _touchWellProtectedMultiTapTimeMs > 300) {
          _touchWellProtectedMultiTapTimeMs = now;
          final tap = onTap;
          if(tap != null) {
            tap();
          }
        }
      } : null : onTap,
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
