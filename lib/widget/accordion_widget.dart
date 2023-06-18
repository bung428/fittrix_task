import 'package:fittrix_task/util/capitalize_helper.dart';
import 'package:fittrix_task/widget/modal_item_widget.dart';
import 'package:flutter/material.dart';

import 'box_widget.dart';

class AccordionWidget<T extends Enum> extends StatelessWidget {
  const AccordionWidget({
    Key? key,
    required this.isExpanded,
    required this.widgetOffset,
    required this.items,
    required this.clickWidgetHeight,
    required this.valueCallback,
  }) : super(key: key);

  final Offset widgetOffset;
  final List<T> items;
  final bool isExpanded;
  final double clickWidgetHeight;
  final Function(T data) valueCallback;

  @override
  Widget build(BuildContext context) {
    final centerHeight = MediaQuery.of(context).size.height / 2;

    final leftPos = (widgetOffset.dx - 50) > 0
        ? widgetOffset.dx - 50 : widgetOffset.dx;
    final topPos = widgetOffset.dy > centerHeight
        ? widgetOffset.dy - clickWidgetHeight - getAccordionHeight() + 15
        : widgetOffset.dy + (clickWidgetHeight / 2) + 15;
    return Visibility(
        visible: isExpanded,
        child: Positioned(
            left: leftPos,
            top: topPos,
            child: SizedBox(
              width: 200,
              child: AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: getAccordionHeight() + 20,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)
                      ),
                      color: Colors.white,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: items.map((e) {
                        final index = items.indexOf(e);
                        Widget child = ModalItemWidget(
                          value: e.name.capitalize(),
                          onTab: () {
                            valueCallback(e);
                          },
                        );
                        if (index != items.length - 1) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              child,
                              const ColumnBox(12)
                            ],
                          );
                        } else {
                          return child;
                        }
                      }).toList(),
                    ),
                  ),
                ),
                firstCurve: const Interval(0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve: const Interval(0.4, 1, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500),
              ),
            )
          // Container(
          //   width: 50,
          //   height: 50,
          //   color: Colors.red,
          //   child: Text('hihihi')
          // ),
        )
    );
  }

  int getAccordionHeight() {
    final length = items.length;
    final boxHeight = 12 * (length - 1);
    final itemsHeight = 36 * length;
    return boxHeight + itemsHeight;
  }
}
