import 'package:fittrix_task/page/main/data/main_tab.dart';
import 'package:fittrix_task/widget/touch_well_widget.dart';
import 'package:flutter/material.dart';

class BottomTabBarItem extends StatelessWidget {
  final MainTab tab;
  final bool selected;
  final Function() onTap;

  const BottomTabBarItem({
    Key? key,
    required this.tab,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.transparent : Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: selected ? Colors.purple.shade300 : Colors.white,
        ),
        child: Center(child: Text(tab.name)),
      ),
    );
  }
}