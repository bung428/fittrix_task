import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/expanded_model.dart';
import 'package:fittrix_task/page/main/data/main_tab.dart';
import 'package:fittrix_task/page/main/data/vided_data.dart';
import 'package:fittrix_task/page/main/data/video_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class MainBLoC extends BLoC with VideoBLoC{
  Map<MainTab, bool> tabExpanded = {
    MainTab.write: false,
    MainTab.read: false,
  };
  MainTab? expandedTab;

  final selectedTab = BehaviorSubject<MainTab?>()..value = null;
  Stream<MainTab?> get selectedTabStream => selectedTab.stream;

  final menuExpanded = BehaviorSubject<ExpandedModel>()..value = ExpandedModel(
    null, false
  );
  Stream<ExpandedModel> get menuExpandedStream => menuExpanded.stream;

  @override
  void onBLoCLaunched() {
    _initVideoController();
  }

  @override
  void dispose() {
    selectedTab.close();
    menuExpanded.close();

    videoState.dispose();
    videoPlayerController?.dispose();
  }

  void showAccordion(MainTab tab) {
    expandedTab = tab;

    bool? isExpanded = tabExpanded[tab];
    final otherTab = tab == MainTab.write
        ? MainTab.read : MainTab.write;
    bool? otherExpanded = tabExpanded[otherTab];
    if (isExpanded == null || otherExpanded == null) {
      return;
    }
    if (otherExpanded) {
      tabExpanded[otherTab] = false;
    }
    menuExpanded.value = ExpandedModel(tab, !isExpanded);
    tabExpanded[tab] = !isExpanded;
  }

  void resetModel() {
    menuExpanded.value = ExpandedModel(
        null, false
    );
  }
}

mixin VideoBLoC on BLoC {
  late Future<void> initVideoPlayer;

  VideoPlayerController? videoPlayerController;

  int currentVideoIndex = 0;

  final ValueNotifier<VideoState> videoState = ValueNotifier<VideoState>(VideoState.load);

  Future<void> setVideoDone() async {
    await videoPlayerController?.pause();

    videoState.value = VideoState.done;
  }

  Future<void> _initVideoController() async {
    videoPlayerController = VideoPlayerController.asset(
        VideoData.values[currentVideoIndex].value
    )..initialize().then((_) {
      setState(() {});
    });
    //
    if (videoPlayerController == null) {
      return;
    }
    await videoPlayerController?.play();
    videoState.value = VideoState.play;

    videoPlayerController?.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    final controller = videoPlayerController;
    if (controller == null) {
      return;
    }
    final isDone = videoState.value == VideoState.done;
    if (!isDone && controller.value.position >= controller.value.duration) {
      _playNextVideo();
    }
  }

  void _playNextVideo() async {
    currentVideoIndex++;

    if (currentVideoIndex >= VideoData.values.length) {
      await videoPlayerController?.pause();

      videoState.value = VideoState.done;
    } else {
      videoPlayerController?.dispose();
      _initVideoController();
    }
  }

  void replayVideo() {
    currentVideoIndex = 0;

    videoPlayerController?.dispose();
    _initVideoController();
  }

  void turnOffVideo() async {
    final controller = videoPlayerController;
    if (controller != null && controller.value.isPlaying) {
      await setVideoDone();
    }
  }
}