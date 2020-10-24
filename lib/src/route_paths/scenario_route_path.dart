import 'package:flutter/foundation.dart';
import 'package:train_simulator_utilities/src/route_paths/route_path.dart';

class ScenarioRoutePath extends RoutePath {
  final String routeId;
  final String scenarioId;

  const ScenarioRoutePath({
    @required this.routeId,
    @required this.scenarioId,
  });
}
