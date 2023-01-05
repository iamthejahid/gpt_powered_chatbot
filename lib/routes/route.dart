// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/home_page/home_page.dart';

class AppRoutes {
  static const MAIN = '/main';
  static GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        )
      ]);
}
