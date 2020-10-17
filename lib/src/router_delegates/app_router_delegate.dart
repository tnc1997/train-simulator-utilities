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

  final RouterStateData notifier;

  AppRouterDelegate({
    @required this.notifier,
  }) {
    notifier.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return RouterState(
      notifier: notifier,
      child: Navigator(
        key: navigatorKey,
        pages: [
          const MaterialPage<void>(
            child: const HomePage(),
            key: const Key('home_page'),
          ),
          if (notifier.path is SettingsRoutePath)
            const MaterialPage<void>(
              child: const SettingsPage(),
              key: const Key('settings_page'),
            ),
        ],
        onPopPage: (route, result) {
          final path = notifier.path;
          final success = route.didPop(result);

          if (success) {
            if (path is SettingsRoutePath) {
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
