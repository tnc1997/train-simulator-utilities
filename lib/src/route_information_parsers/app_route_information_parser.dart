import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:train_simulator_utilities/src/configurations/router_configuration.dart';
import 'package:train_simulator_utilities/src/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/scenario_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/settings_route_path.dart';

const _kHomePageLocation = '/';
const _kRoutesPageLocation = '/routes';
const _kScenariosPageLocation = '/scenarios';
const _kSettingsPageLocation = '/settings';

class AppRouteInformationParser
    extends RouteInformationParser<RouterConfiguration> {
  @override
  Future<RouterConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments[0] == 'routes') {
        if (uri.pathSegments.length == 1) {
          return SynchronousFuture(
            RouterConfiguration(
              path: RoutesRoutePath(),
              state: routeInformation.state,
            ),
          );
        } else if (uri.pathSegments.length == 2) {
          return SynchronousFuture(
            RouterConfiguration(
              path: RouteRoutePath(
                id: uri.pathSegments[1],
              ),
              state: routeInformation.state,
            ),
          );
        }
      } else if (uri.pathSegments[0] == 'scenarios') {
        if (uri.pathSegments.length == 1) {
          return SynchronousFuture(
            RouterConfiguration(
              path: ScenariosRoutePath(),
              state: routeInformation.state,
            ),
          );
        } else if (uri.pathSegments.length == 2) {
          return SynchronousFuture(
            RouterConfiguration(
              path: ScenarioRoutePath(
                id: uri.pathSegments[1],
              ),
              state: routeInformation.state,
            ),
          );
        }
      } else if (uri.pathSegments[0] == 'settings') {
        if (uri.pathSegments.length == 1) {
          return SynchronousFuture(
            RouterConfiguration(
              path: SettingsRoutePath(),
              state: routeInformation.state,
            ),
          );
        }
      }
    }

    return SynchronousFuture(
      RouterConfiguration(
        path: HomeRoutePath(),
        state: routeInformation.state,
      ),
    );
  }

  @override
  RouteInformation restoreRouteInformation(
    RouterConfiguration configuration,
  ) {
    final path = configuration.path;

    if (path is HomeRoutePath) {
      return RouteInformation(
        location: _kHomePageLocation,
        state: configuration.state,
      );
    } else if (path is RouteRoutePath) {
      return RouteInformation(
        location: '$_kRoutesPageLocation/${path.id}',
        state: configuration.state,
      );
    } else if (path is RoutesRoutePath) {
      return RouteInformation(
        location: _kRoutesPageLocation,
        state: configuration.state,
      );
    } else if (path is ScenarioRoutePath) {
      return RouteInformation(
        location: '$_kScenariosPageLocation/${path.id}',
        state: configuration.state,
      );
    } else if (path is ScenariosRoutePath) {
      return RouteInformation(
        location: _kScenariosPageLocation,
        state: configuration.state,
      );
    } else if (path is SettingsRoutePath) {
      return RouteInformation(
        location: _kSettingsPageLocation,
        state: configuration.state,
      );
    }

    return null;
  }
}
