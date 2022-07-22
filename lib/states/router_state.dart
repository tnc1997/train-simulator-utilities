import 'package:flutter/widgets.dart';
import 'package:train_simulator_utilities/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/route_paths/route_path.dart';

class RouterState extends InheritedNotifier<RouterStateData> {
  const RouterState({
    Key? key,
    RouterStateData? notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static RouterStateData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouterState>()?.notifier;
  }
}

class RouterStateData extends ChangeNotifier {
  RoutePath _path = const HomeRoutePath();

  RoutePath get path => _path;

  set path(RoutePath value) {
    if (value != _path) {
      _path = value;
      notifyListeners();
    }
  }
}
