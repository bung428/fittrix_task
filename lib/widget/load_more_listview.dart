import 'package:flutter/material.dart';

typedef LoadMoreCallback<T> = Future<void> Function();

class LoadMoreListViewWidget<T> extends StatefulWidget {
  final List<T> list;
  final Widget? moreWidget;
  final Widget? emptyWidget;
  final Widget? nullWidget;
  final Widget sliverListWidget;
  final LoadMoreCallback<T> onLoadMoreCallback;

  const LoadMoreListViewWidget({
    Key? key,
    this.nullWidget,
    this.moreWidget,
    this.emptyWidget,
    required this.list,
    required this.sliverListWidget,
    required this.onLoadMoreCallback
  }) : super(key: key);

  @override
  State<LoadMoreListViewWidget> createState() => _LoadMoreListViewWidgetState();
}

class _LoadMoreListViewWidgetState extends State<LoadMoreListViewWidget> {
  late ScrollController controller;

  bool loadMore = false;
  bool enableLoadMore = true;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadMoreListViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.list != oldWidget.list) {
      _setState();
    }
  }

  void _setState() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadMore() async {
    if (loadMore) {
      return;
    }
    if (!enableLoadMore) {
      return;
    }

    if (!loadMore && controller.position.extentAfter < 100) {
      setState(() {
        loadMore = true;
      });

      try {
        if (enableLoadMore) {
          setState(() {
            enableLoadMore = false;
          });
          widget.onLoadMoreCallback().whenComplete(() {
            setState(() {
              loadMore = false;
              enableLoadMore = true;
            });
          });
        }

      } catch (_) {
        setState(() {
          loadMore = false;
          enableLoadMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            widget.sliverListWidget,
          ],
        ),
        if (loadMore && widget.moreWidget != null)
          Center(
            child: widget.moreWidget,
          ),
      ],
    );
  }
}
