import 'package:flutter/foundation.dart';
import 'package:train_simulator_utilities/src/route_paths/route_path.dart';

class RouterConfiguration {
  final RoutePath path;
  final Map<String, dynamic> state;

  RouterConfiguration({
    @required this.path,
    @required this.state,
  });
}
