import 'package:flutter/widgets.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;

class AppState extends InheritedNotifier<AppStateData> {
  const AppState({
    Key key,
    AppStateData notifier,
    @required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static AppStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>().notifier;
  }
}

class AppStateData extends ChangeNotifier {
  TrainSimulatorClient _client;
  String _path;

  AppStateData({
    TrainSimulatorClient client,
    String path,
  })  : _client = client,
        _path = path;

  TrainSimulatorClient get client => _client;

  set client(TrainSimulatorClient value) {
    if (value != _client) {
      _client = value;
      notifyListeners();
    }
  }

  String get path => _path;

  set path(String value) {
    if (value != _path) {
      _client = TrainSimulatorClient(
        options: TrainSimulatorClientOptions(
          path: value,
        ),
      );
      _path = value;
      notifyListeners();
    }
  }
}
