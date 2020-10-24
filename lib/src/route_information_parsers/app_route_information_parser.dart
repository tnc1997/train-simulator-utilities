import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:train_simulator_utilities/src/configurations/router_configuration.dart';
import 'package:train_simulator_utilities/src/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/scenario_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/settings_route_path.dart';

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
                routeId: uri.pathSegments[1],
              ),
              state: routeInformation.state,
            ),
          );
        } else if (uri.pathSegments.length == 3) {
          return SynchronousFuture(
            RouterConfiguration(
              path: ScenariosRoutePath(
                routeId: uri.pathSegments[1],
              ),
              state: routeInformation.state,
            ),
          );
        } else if (uri.pathSegments.length == 4) {
          return SynchronousFuture(
            RouterConfiguration(
              path: ScenarioRoutePath(
                routeId: uri.pathSegments[1],
                scenarioId: uri.pathSegments[3],
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
        location: '/',
        state: configuration.state,
      );
    } else if (path is RouteRoutePath) {
      return RouteInformation(
        location: '/routes/${path.routeId}',
        state: configuration.state,
      );
    } else if (path is RoutesRoutePath) {
      return RouteInformation(
        location: '/routes',
        state: configuration.state,
      );
    } else if (path is ScenarioRoutePath) {
      return RouteInformation(
        location: '/routes/${path.routeId}/scenarios/${path.scenarioId}',
        state: configuration.state,
      );
    } else if (path is ScenariosRoutePath) {
      return RouteInformation(
        location: '/routes/${path.routeId}/scenarios',
        state: configuration.state,
      );
    } else if (path is SettingsRoutePath) {
      return RouteInformation(
        location: '/settings',
        state: configuration.state,
      );
    }

    return null;
  }
}
