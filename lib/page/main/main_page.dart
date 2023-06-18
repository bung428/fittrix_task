import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/page/main/data/main_tab.dart';
import 'package:fittrix_task/page/main/data/video_state.dart';
import 'package:fittrix_task/page/main/main_bloc.dart';
import 'package:fittrix_task/route/app_links.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:fittrix_task/widget/accordion_widget.dart';
import 'package:fittrix_task/widget/main/bottom_tab_bar_item_widget.dart';
import 'package:fittrix_task/widget/stream_builder_widget.dart';
import 'package:fittrix_task/widget/touch_well_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class MainPage extends BLoCProvider<MainBLoC> {
  MainPage({super.key, required this.state, this.child});

  final GoRouterState state;
  final Widget? child;
  final GlobalKey _readWidgetKey = GlobalKey();
  final GlobalKey _writeWidgetKey = GlobalKey();
  final GlobalKey _bottomTabKey = GlobalKey();

  Offset btnOffset = Offset.zero;
  double tabHeight = 0;

  @override
  MainBLoC createBLoC() => MainBLoC();

  @override
  Widget build(BuildContext context, MainBLoC bloc) {
    final path = state.fullPath;
    if (path == null) {
      return const Placeholder();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: child == null ? _buildMainVideoView(bloc) : child!),
                  StreamBuilderWidget(
                    stream: bloc.selectedTab,
                    builder: (context, tab) {
                      final isSelected = tab != null;
                      return Padding(
                        key: _bottomTabKey,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BottomTabBarItem(
                              key: _writeWidgetKey,
                              tab: MainTab.write,
                              selected: isSelected && tab == MainTab.write,
                              onTap: () => _showAccordionModal(_writeWidgetKey, MainTab.write, bloc),
                            ),
                            BottomTabBarItem(
                              key: _readWidgetKey,
                              tab: MainTab.read,
                              selected: isSelected && tab == MainTab.read,
                              onTap: () => _showAccordionModal(_readWidgetKey, MainTab.read, bloc),
                            ),
                            BottomTabBarItem(
                              tab: MainTab.login,
                              selected: isSelected && tab == MainTab.login,
                              onTap: () => _navToLoginPage(context, bloc),
                            ),
                          ],
                        ),
                      );
                    }
                  )
                ],
              ),
              StreamBuilderWidget(
                stream: bloc.menuExpanded,
                builder: (context, model) {
                  if (model == null) {
                    return Container();
                  }
                  final tab = model.tab;
                  final isExpanded = model.isExpanded;
                  return Visibility(
                    visible: isExpanded,
                    child: AccordionWidget<ExType>(
                      isExpanded: isExpanded,
                      items: ExType.values,
                      widgetOffset: btnOffset,
                      clickWidgetHeight: tabHeight,
                      valueCallback: (data) {
                        if (tab != null) {
                          bloc.resetModel();
                          _navToPage(context, bloc, tab, data);
                        }
                      }
                    )
                  );
                }
              )
            ],
          )
      ),
    );
  }

  Widget _buildMainVideoView(MainBLoC bloc) {
    final controller = bloc.videoPlayerController;
    if (controller == null) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
          valueListenable: bloc.videoState,
          builder: (context, state, Widget? child) {
            switch (state) {
              case VideoState.load:
                return const Center(child: CircularProgressIndicator());
              case VideoState.play:
                return Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: VideoPlayer(controller)
                    ),
                  ),
                );
              case VideoState.done:
                return TouchWell(
                  onTap: bloc.replayVideo,
                  child: const Center(
                    child: Icon(Icons.play_circle, size: 88,),
                  ),
                );
            }
          }
      ),
    );
  }

  Future<void> _navToPage(BuildContext context, MainBLoC bloc, MainTab tab, ExType exType) async {
    bloc.turnOffVideo();
    if (tab == MainTab.read) {
      // ignore: use_build_context_synchronously
      context.go(
        '/${AppLinks.read_exercise.linkPath}?exType=${exType.name}',);
    } else if (tab == MainTab.write) {
      // ignore: use_build_context_synchronously
      context.go(
        '/${AppLinks.write_exercise.linkPath}?exType=${exType.name}',);
    }
  }

  void _navToLoginPage(BuildContext context, MainBLoC bloc) {
    final isLogin = AuthService.instance.isLogin;
    if (isLogin) {
      const snackBar = SnackBar(content: Text('이미 로그인한 상태입니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      bloc.turnOffVideo();
      context.go('/${AppLinks.login.linkPath}');
    }
  }

  void _showAccordionModal(GlobalKey key, MainTab tab, MainBLoC bloc) {
    btnOffset = getWidgetOffset(key);
    tabHeight = getWidgetSize(_bottomTabKey).height;
    bloc.showAccordion(tab);
  }

  Size getWidgetSize(GlobalKey key) {
    if (key.currentContext != null) {
      final renderBox = key.currentContext!.findRenderObject() as RenderBox;
      return renderBox.size;
    }
    return Size.zero;
  }

  Offset getWidgetOffset(GlobalKey key) {
    if (key.currentContext != null) {
      final renderBox = key.currentContext!.findRenderObject() as RenderBox;
      return renderBox.localToGlobal(Offset.zero);
    }
    return Offset.zero;
  }
}