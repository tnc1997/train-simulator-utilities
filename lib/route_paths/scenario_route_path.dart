import 'dart:io';

import 'package:train_simulator_utilities/route_paths/route_path.dart';

class ScenarioRoutePath extends RoutePath {
  final Directory directory;

  const ScenarioRoutePath({
    required this.directory,
  });
}
