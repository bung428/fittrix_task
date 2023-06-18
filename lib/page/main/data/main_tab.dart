import 'package:fittrix_task/route/app_links.dart';
import 'package:flutter/material.dart';

enum MainTab {
  write('운동 기록 하기'),
  read('운동 기록 보기'),
  login('로그인');

  final String name;

  const MainTab(this.name);
}

extension MainTabExt on MainTab {
  Widget get icon {
    switch (this) {
      case MainTab.read:
        return const Icon(Icons.read_more);
      case MainTab.write:
        return const Icon(Icons.create);
      case MainTab.login:
        return const Icon(Icons.login);
    }
  }

  String get path {
    switch (this) {
      case MainTab.read:
        return AppLinks.read_exercise.linkPath;
      case MainTab.write:
        return AppLinks.write_exercise.linkPath;
      case MainTab.login:
        return AppLinks.login.linkPath;
    }
  }
}