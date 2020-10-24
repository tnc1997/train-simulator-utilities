import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/src/configurations/router_configuration.dart';
import 'package:train_simulator_utilities/src/pages/home_page.dart';
import 'package:train_simulator_utilities/src/pages/route_page.dart';
import 'package:train_simulator_utilities/src/pages/routes_page.dart';
import 'package:train_simulator_utilities/src/pages/scenarios_page.dart';
import 'package:train_simulator_utilities/src/pages/settings_page.dart';
import 'package:train_simulator_utilities/src/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/settings_route_path.dart';
import 'package:train_simulator_utilities/src/states/router_state.dart';

class AppRouterDelegate extends RouterDelegate<RouterConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterConfiguration> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final RouterStateData notifier;

  AppRouterDelegate({
    @required this.notifier,
  }) {
    notifier.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    final path = notifier.path;

    final pages = [
      const MaterialPage<void>(
        child: const HomePage(),
        key: const Key('home_page'),
      ),
    ];

    if (path is RouteRoutePath) {
      pages.addAll(
        [
          const MaterialPage<void>(
            child: const RoutesPage(),
            key: const Key('routes_page'),
          ),
          MaterialPage<void>(
            child: RoutePage(
              routeId: path.routeId,
            ),
            key: Key('route_page'),
          ),
        ],
      );
    } else if (path is RoutesRoutePath) {
      pages.add(
        const MaterialPage<void>(
          child: const RoutesPage(),
          key: const Key('routes_page'),
        ),
      );
    } else if (path is ScenariosRoutePath) {
      pages.addAll(
        [
          const MaterialPage<void>(
            child: const RoutesPage(),
            key: const Key('routes_page'),
          ),
          MaterialPage<void>(
            child: RoutePage(
              routeId: path.routeId,
            ),
            key: Key('route_page'),
          ),
          MaterialPage<void>(
            child: ScenariosPage(
              routeId: path.routeId,
            ),
            key: const Key('scenarios_page'),
          ),
        ],
      );
    } else if (path is SettingsRoutePath) {
      pages.add(
        const MaterialPage<void>(
          child: const SettingsPage(),
          key: const Key('settings_page'),
        ),
      );
    }

    return RouterState(
      notifier: notifier,
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          final success = route.didPop(result);

          if (success) {
            if (path is RouteRoutePath) {
              notifier.path = const RoutesRoutePath();
            } else if (path is RoutesRoutePath) {
              notifier.path = const HomeRoutePath();
            } else if (path is ScenariosRoutePath) {
              notifier.path = RouteRoutePath(
                routeId: path.routeId,
              );
            } else if (path is SettingsRoutePath) {
              notifier.path = const HomeRoutePath();
            }
          }

          return success;
        },
      ),
    );
  }

  @override
  RouterConfiguration get currentConfiguration {
    return RouterConfiguration(
      path: notifier.path,
      state: notifier.state,
    );
  }

  @override
  void dispose() {
    notifier.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Future<void> setNewRoutePath(RouterConfiguration configuration) async {
    notifier.path = configuration.path;
    notifier.state = configuration.state;
  }
}
