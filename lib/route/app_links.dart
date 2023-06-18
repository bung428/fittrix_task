// ignore_for_file: constant_identifier_names, avoid_print

import 'package:fittrix_task/page/login/login_page.dart';
import 'package:fittrix_task/page/read/read_page.dart';
import 'package:fittrix_task/page/write/write_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Links {
  String get linkPath;
}

extension LinksExtension on Links {
  /// path 쌓으며 navigation
  void go(
      BuildContext context, {
        Map<String, String> params = const <String, String>{},
        Map<String, String> queryParams = const <String, String>{},
        Object? extra,
      }) async {
    final goRouter = GoRouter.of(context);
    print('Links go : current location : ${goRouter.location}');
    final currentUri = Uri.parse(goRouter.location);
    print(
        'Links go : current path : ${currentUri.path}, query : ${currentUri.query}');

    final Map<String, String> encodedParams = <String, String>{
      for (final MapEntry<String, String> param in params.entries)
        param.key: Uri.encodeComponent(param.value)
    };
    final String location = patternToPath(linkPath, encodedParams);
    print('Links go : location : $location');

    final uri = Uri(
        path: _composePath(currentUri.path, location),
        queryParameters: queryParams.isEmpty ? null : queryParams);
    print(
        'Links go : ${uri.toString()} path : ${uri.path}, query : ${uri.query}');
    context.go(uri.toString(), extra: extra);
  }
}

final RegExp _parameterRegExp = RegExp(r':(\w+)(\((?:\\.|[^\\()])+\))?');

String patternToPath(String pattern, Map<String, String> pathParameters) {
  final StringBuffer buffer = StringBuffer();
  int start = 0;
  for (final RegExpMatch match in _parameterRegExp.allMatches(pattern)) {
    if (match.start > start) {
      buffer.write(pattern.substring(start, match.start));
    }
    final String name = match[1]!;
    buffer.write(pathParameters[name]);
    start = match.end;
  }

  if (start < pattern.length) {
    buffer.write(pattern.substring(start));
  }
  return buffer.toString();
}

String _composePath(String parent, String path) {
  StringBuffer sb = StringBuffer();
  if(parent.endsWith('/')) {
    sb.write(parent);
  } else {
    sb.write(parent);
    sb.write('/');
  }
  sb.write(path);

  return sb.toString();
}

enum RootLinks implements Links {
  home('/')
  ;

  @override
  final String linkPath;

  const RootLinks(this.linkPath);
}

enum AppLinks implements Links {
  write_exercise('write_exercise'),
  read_exercise('read_exercise'),
  login('login')
  ;

  @override
  final String linkPath;

  const AppLinks(this.linkPath);
}

extension AppLinksRoute on AppLinks {
  GoRoute getRoute({String? name, String? path}) {
    switch (this) {
      case AppLinks.write_exercise:
        return GoRoute(
          name: name ?? linkPath,
          path: path ?? linkPath,
          pageBuilder: (
              context,
              state,
              ) {
            return MaterialPage(
                key: state.pageKey,
                name: state.location,
                arguments: state.extra,
                child: WritePage(exType: state.queryParameters['exType'] ?? ''));
          },
        );
      case AppLinks.read_exercise:
        return GoRoute(
          name: name ?? linkPath,
          path: path ?? linkPath,
          pageBuilder: (
              context,
              state,
              ) {
            return MaterialPage(
                key: state.pageKey,
                name: state.location,
                arguments: state.extra,
                child: ReadPage(exType: state.queryParameters['exType'] ?? ''));
          },
        );
      case AppLinks.login:
        return GoRoute(
          name: name ?? linkPath,
          path: path ?? linkPath,
          pageBuilder: (
              context,
              state,
              ) {
            return MaterialPage(
                key: state.pageKey,
                name: state.location,
                arguments: state.extra,
                child: LoginPage(loginToLocation: state.queryParameters['login_to_location'],));
          },
        );
    }
  }
}
