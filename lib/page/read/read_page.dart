import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/model/record_model.dart';
import 'package:fittrix_task/page/read/read_bloc.dart';
import 'package:fittrix_task/util/enum_extension.dart';
import 'package:fittrix_task/widget/box_widget.dart';
import 'package:fittrix_task/widget/load_more_listview.dart';
import 'package:fittrix_task/widget/stream_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReadPage extends BLoCProvider<ReadBLoC> {
  const ReadPage({Key? key, required this.exType}) : super(key: key);

  final String exType;

  @override
  Widget build(BuildContext context, ReadBLoC bloc) {
    final type = ExType.values.tryByName(exType);
    if (type == null) {
      return const Placeholder();
    }
    bloc.setType(type);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(type.typeName),
          leading:
              IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilderWidget(
            stream: bloc.exRecordsStream,
            builder: (context, List<RecordModel>? items) {
              if (items == null) {
                return Container();
              }
              if (items.isEmpty) {
                return const Center(child: Text('기록이 없습니다.'),);
              }
              return LoadMoreListViewWidget(
                list: items,
                onLoadMoreCallback: bloc.loadMore,
                sliverListWidget: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Widget child = RecordItemWidget(
                      record: items[index],
                    );
                    if (index != items.length - 1) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          child,
                          const ColumnBox(12),
                        ],
                      );
                    } else {
                      return child;
                    }
                  },
                  childCount: items.length,
                )),
                moreWidget: Container(
                  alignment: AlignmentDirectional.center,
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        )));
  }

  @override
  ReadBLoC createBLoC() => ReadBLoC();
}

class RecordItemWidget extends StatelessWidget {
  const RecordItemWidget({Key? key, required this.record}) : super(key: key);

  final RecordModel record;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 36,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.grey,
            ),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(record.date),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(record.msg),
          ))
        ],
      ),
    );
  }
}
