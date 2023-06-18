import 'package:fittrix_task/widget/touch_well_widget.dart';
import 'package:flutter/material.dart';

class ModalItemWidget extends StatelessWidget {
  const ModalItemWidget({
    Key? key, required this.value, required this.onTab}) : super(key: key);

  final String value;
  final GestureTapCallback onTab;

  @override
  Widget build(BuildContext context) {
    return TouchWell(
      onTap: onTab,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(child: Text(value)),
      ),
    );
  }
}
