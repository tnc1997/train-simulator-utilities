import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:train_simulator_utilities/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/route_paths/route_path.dart';
import 'package:train_simulator_utilities/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/route_paths/scenario_route_path.dart';
import 'package:train_simulator_utilities/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/route_paths/settings_route_path.dart';
import 'package:train_simulator_utilities/states/app_state.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  final AppStateData _appStateData;

  AppRouteInformationParser({
    required AppStateData appStateData,
  }) : _appStateData = appStateData;

  @override
  Future<RoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments[0] == 'routes') {
        if (uri.pathSegments.length == 1) {
          return SynchronousFuture(RoutesRoutePath());
        } else if (uri.pathSegments.length == 2) {
          return SynchronousFuture(
            RouteRoutePath(
              directory: Directory(join(
                _appStateData.getRootPath()!,
                'Content',
                'Routes',
                uri.pathSegments[1],
              )),
            ),
          );
        } else if (uri.pathSegments.length == 3) {
          return SynchronousFuture(
            ScenariosRoutePath(
              directory: Directory(join(
                _appStateData.getRootPath()!,
                'Content',
                'Routes',
                uri.pathSegments[1],
              )),
            ),
          );
        } else if (uri.pathSegments.length == 4) {
          return SynchronousFuture(
            ScenarioRoutePath(
              directory: Directory(join(
                _appStateData.getRootPath()!,
                'Content',
                'Routes',
                uri.pathSegments[1],
                'Scenarios',
                uri.pathSegments[3],
              )),
            ),
          );
        }
      } else if (uri.pathSegments[0] == 'settings') {
        if (uri.pathSegments.length == 1) {
          return SynchronousFuture(SettingsRoutePath());
        }
      }
    }

    return SynchronousFuture(HomeRoutePath());
  }

  @override
  RouteInformation? restoreRouteInformation(
    RoutePath configuration,
  ) {
    if (configuration is HomeRoutePath) {
      return RouteInformation(
        location: '/',
      );
    } else if (configuration is RouteRoutePath) {
      return RouteInformation(
        location: '/routes/${configuration.directory}',
      );
    } else if (configuration is RoutesRoutePath) {
      return RouteInformation(
        location: '/routes',
      );
    } else if (configuration is ScenarioRoutePath) {
      final components = split(configuration.directory.path);
      return RouteInformation(
        location:
            '/routes/${components[components.length - 3]}/scenarios/${components[components.length - 1]}',
      );
    } else if (configuration is ScenariosRoutePath) {
      return RouteInformation(
        location: '/routes/${configuration.directory}/scenarios',
      );
    } else if (configuration is SettingsRoutePath) {
      return RouteInformation(
        location: '/settings',
      );
    }

    return null;
  }
}
