import 'package:fittrix_task/page/main/main_page.dart';
import 'package:fittrix_task/route/app_links.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter get appRouter => GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: appNavigatorKey,
  routes: [
    GoRoute(
      name: RootLinks.home.name,
      path: RootLinks.home.linkPath,
      pageBuilder: (
          context,
          state,
          ) {
        return NoTransitionPage(
            key: state.pageKey,
            name: state.location,
            arguments: state.extra,
            child: MainPage(state: state, child: null,));
      },
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          routes: [
            AppLinks.write_exercise.getRoute(name: AppLinks.write_exercise.name),
            AppLinks.read_exercise.getRoute(name: AppLinks.read_exercise.name),
            AppLinks.login.getRoute(name: AppLinks.login.name),
          ],
          builder: (context, state, child) => MainPage(state: state, child: child),
        )
      ],
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    // ignore: avoid_print
    print(
        'GoRoute redirect - location : ${state.location}, name : ${state.name}');
    List<String> locationList = [];
    if (state.location.contains('?')) {
      locationList = state.location.split('?');
    }
    if (!AuthService.instance.isLogin ) {
      if ((locationList.isEmpty && needLoginLinks.contains(state.location)) ||
(locationList.isNotEmpty && needLoginLinks.contains(locationList.first))) {
        // ignore: deprecated_member_use
        return state.namedLocation(AppLinks.login.name,
            queryParameters: {'login_to_location': state.location});
      }
    }
    return null;
  },
);

final needLoginLinks = {
  '/${AppLinks.read_exercise.linkPath}',
  '/${AppLinks.write_exercise.linkPath}',
};