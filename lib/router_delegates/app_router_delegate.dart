import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/pages/home_page.dart';
import 'package:train_simulator_utilities/pages/route_page.dart';
import 'package:train_simulator_utilities/pages/routes_page.dart';
import 'package:train_simulator_utilities/pages/scenarios_page.dart';
import 'package:train_simulator_utilities/pages/settings_page.dart';
import 'package:train_simulator_utilities/route_paths/route_path.dart';
import 'package:train_simulator_utilities/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/route_paths/settings_route_path.dart';
import 'package:train_simulator_utilities/states/router_state.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final RouterStateData routerStateData;

  AppRouterDelegate({
    required this.routerStateData,
  }) {
    routerStateData.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    final path = routerStateData.path;

    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage<void>(
          child: const HomePage(),
          key: const ValueKey('home_page'),
        ),
        if (path is RouteRoutePath) ...[
          const MaterialPage<void>(
            child: const RoutesPage(),
            key: const ValueKey('routes_page'),
          ),
          MaterialPage<void>(
            child: RoutePage(
              directory: path.directory,
            ),
            key: ValueKey('route_page'),
          ),
        ] else if (path is RoutesRoutePath)
          const MaterialPage<void>(
            child: const RoutesPage(),
            key: const ValueKey('routes_page'),
          )
        else if (path is ScenariosRoutePath) ...[
          const MaterialPage<void>(
            child: const RoutesPage(),
            key: const ValueKey('routes_page'),
          ),
          MaterialPage<void>(
            child: RoutePage(
              directory: path.directory,
            ),
            key: ValueKey('route_page'),
          ),
          MaterialPage<void>(
            child: ScenariosPage(
              directory: path.directory,
            ),
            key: const ValueKey('scenarios_page'),
          ),
        ] else if (path is SettingsRoutePath)
          const MaterialPage<void>(
            child: const SettingsPage(),
            key: const ValueKey('settings_page'),
          ),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  RoutePath get currentConfiguration {
    return routerStateData.path;
  }

  @override
  void dispose() {
    routerStateData.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    routerStateData.path = configuration;
  }
}
