import 'package:esacc_flutter_task/core/di/injectable_initializer.dart';
import 'package:esacc_flutter_task/features/auth/presentation/ViewModel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages_route.dart';
import 'package:esacc_flutter_task/features/auth/presentation/View/login_page.dart';
import 'package:esacc_flutter_task/features/settings/presentation/View/settings_page.dart';
import 'package:esacc_flutter_task/features/webview/presentation/View/webview_page.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoute.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case PagesRoute.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      case PagesRoute.webview:
        return MaterialPageRoute(
          builder: (_) => const WebViewPage(),
        );
      default:
        return _unDefinedRoute();
    }
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Un defined route"),
            centerTitle: true,
          ),
          body: const Center(child: Text("Un defined route")),
        );
      },
    );
  }
}
