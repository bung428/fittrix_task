import 'package:fittrix_task/widget/touch_well_widget.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, this.onTap, required this.child}) : super(key: key);

  final GestureTapCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: onTap != null ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: TouchWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.3)
          ),
          alignment: AlignmentDirectional.center,
          child: child,
        ),
      ),
    );
  }
}
