import 'package:fittrix_task/route/app_router.dart';
import 'package:fittrix_task/service/api_service.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:flutter/material.dart';

class FittrixTaskApp extends StatefulWidget {
  const FittrixTaskApp({Key? key}) : super(key: key);

  @override
  State<FittrixTaskApp> createState() => _FittrixTaskAppState();
}

class _FittrixTaskAppState extends State<FittrixTaskApp> {
  @override
  void initState() {
    super.initState();
    /// inject
    AuthService.instance.init();
    ApiService.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fittrix Task',
      routerConfig: appRouter,
      theme: ThemeData(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}