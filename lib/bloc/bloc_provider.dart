import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BLoC {
  BuildContext Function()? _onBuildContext;
  bool Function()? _onMounted;

  BuildContext? get buildContext {
    if(_onBuildContext != null) {
      return _onBuildContext!();
    }
    return null;
  }

  bool get mounted {
    if(_onMounted != null) {
      return _onMounted!();
    }
    return false;
  }

  void _setOnBuildContext(BuildContext Function()? onBuildContext) {
    _onBuildContext = onBuildContext;
  }

  void _setOnMounted(bool Function() onMounted) {
    _onMounted = onMounted;
  }

  void Function(VoidCallback)? _onSetState;
  void _setOnSetState(void Function(VoidCallback)? onSetState) {
    _onSetState = onSetState;
  }

  void setState(VoidCallback fn) {
    if(mounted && _onSetState != null) {
      _onSetState!(fn);
    } else {
      fn();
    }
  }

  void onBLoCLaunched() {}

  void dispose();
}

abstract class BLoCProvider<T extends BLoC?> extends StatefulWidget {

  const BLoCProvider({Key? key}) : super(key: key);

  static T? of<T extends BLoC>(BuildContext context) {
    final BLoCProviderState<T>? state = context.findAncestorStateOfType<BLoCProviderState<T>>();
    return state?.bloc;
  }

  @override
  State<StatefulWidget> createState() => BLoCProviderState<T>();

  T createBLoC();

  Widget build(BuildContext context, T bloc);


}

class BLoCProviderState<T extends BLoC?> extends State<BLoCProvider> {

  @protected T? bloc;

  @override
  void initState() {
    bloc = widget.createBLoC() as T?;
    bloc?._setOnMounted(() => mounted);
    bloc?._setOnBuildContext(() => context);
    bloc?._setOnSetState((fn) => setState(fn));

    if(bloc != null) {
      initBLoC(bloc);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.onBLoCLaunched();
    });
    super.initState();
  }

  @override
  void dispose() {
    if(bloc != null) {
      if(bloc is BLoCStreamSubscription) {
        (bloc as BLoCStreamSubscription).clearSubscription();
      }
      disposeBLoC(bloc);
      bloc!._setOnSetState(null);
      bloc!._setOnBuildContext(null);
      bloc!.dispose();
      bloc = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = this.bloc;
    if(bloc != null) {
      return Builder(
        builder: (context) {
          return buildBLoC(
            context,
            bloc,
            widget.build(context, bloc)
          );
        },
      );
    }
    return Container();
  }

  void initBLoC(T? bloc) {}

  void disposeBLoC(T? bloc) {}

  Widget buildBLoC(BuildContext context, T? bloc, Widget widget) => widget;
}

mixin BLoCStreamSubscription on BLoC {
  final _compositeSubscription = CompositeSubscription();

  Future<void> onStreamSubscriptionError(Exception e) {
    return Future.value(null);
  }

  StreamSubscription<T> streamSubscription<T>({
    required Stream<T> stream,
    required void Function(T data) onData,
    void Function(bool success)? onDone,
    Exception? Function(Exception exception)? onError,
    void Function()? onShowLoading,
    void Function()? onHideLoading,
  }) {
    return _compositeSubscription.add(
      DeferStream(() => stream,
      ).doOnListen(() {
        if(onShowLoading != null) onShowLoading();
      }).listen(
          onData,
          onError: ([error, stackTrace]) {
            if(onHideLoading != null) onHideLoading();

            if(error is! Exception) {
              return;
            }
            var errorResult = onError != null ? onError(error) : error;
            if(errorResult != null) {
              onStreamSubscriptionError(errorResult);
            }
            if(onDone != null) {
              onDone(false);
            }
          },
          onDone: () {
            if(onHideLoading != null) onHideLoading();

            if(onDone != null) {
              onDone(true);
            }
          },
          cancelOnError: true
      ),
    );
  }

  void disposeSubscription() {
    _compositeSubscription.dispose();
  }

  void clearSubscription() {
    _compositeSubscription.clear();
  }
}