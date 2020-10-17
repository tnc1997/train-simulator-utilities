import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/src/configurations/router_configuration.dart';
import 'package:train_simulator_utilities/src/pages/home_page.dart';
import 'package:train_simulator_utilities/src/pages/settings_page.dart';
import 'package:train_simulator_utilities/src/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/settings_route_path.dart';
import 'package:train_simulator_utilities/src/states/router_state.dart';

class AppRouterDelegate extends RouterDelegate<RouterConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterConfiguration> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final RouterStateData routerState;

  AppRouterDelegate({
    @required this.routerState,
  }) {
    routerState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return RouterState(
      child: Navigator(
        key: navigatorKey,
        onPopPage: (route, result) {
          final path = routerState.path;
          final success = route.didPop(result);

          if (success) {
            if (path is SettingsRoutePath) {
              routerState.path = const HomeRoutePath();
            }
          }

          return success;
        },
        pages: [
          const MaterialPage<void>(
            child: const HomePage(),
            key: const Key('home_page'),
          ),
          if (routerState.path is SettingsRoutePath)
            const MaterialPage<void>(
              child: const SettingsPage(),
              key: const Key('settings_page'),
            ),
        ],
      ),
      routerState: routerState,
    );
  }

  @override
  RouterConfiguration get currentConfiguration {
    return RouterConfiguration(
      path: routerState.path,
      state: routerState.state,
    );
  }

  @override
  void dispose() {
    routerState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Future<void> setNewRoutePath(RouterConfiguration configuration) async {
    routerState.path = configuration.path;
    routerState.state = configuration.state;
  }
}
