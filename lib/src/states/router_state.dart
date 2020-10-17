import 'package:flutter/widgets.dart';
import 'package:train_simulator_utilities/src/route_paths/route_path.dart';

class RouterState extends InheritedNotifier<RouterStateData> {
  const RouterState({
    Key key,
    RouterStateData notifier,
    @required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static RouterStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouterState>().notifier;
  }
}

class RouterStateData extends ChangeNotifier {
  RoutePath _path;
  Map<String, dynamic> _state;

  RoutePath get path => _path;

  set path(RoutePath value) {
    if (value != _path) {
      _path = value;
      notifyListeners();
    }
  }

  Map<String, dynamic> get state => _state;

  set state(Map<String, dynamic> value) {
    if (value != _state) {
      _state = value;
      notifyListeners();
    }
  }
}
