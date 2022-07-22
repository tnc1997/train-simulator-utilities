import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;

class AppState extends InheritedNotifier<AppStateData> {
  const AppState({
    Key? key,
    AppStateData? notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static AppStateData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>()?.notifier;
  }
}

class AppStateData extends ChangeNotifier {
  final SharedPreferences _prefs;

  TrainSimulatorClient? _client;

  AppStateData({
    required SharedPreferences prefs,
  }) : _prefs = prefs {
    final rootPath = getRootPath();
    if (rootPath != null) {
      _client = TrainSimulatorClient(
        rootPath: rootPath,
        railDriverPath: getRailDriverPath(),
        serzPath: getSerzPath(),
      );
    }
  }

  TrainSimulatorClient? get client => _client;

  set client(TrainSimulatorClient? value) {
    if (value != _client) {
      _client = value;
      notifyListeners();
    }
  }

  String? getRailDriverPath() {
    return _prefs.getString('railDriverPath');
  }

  String? getRootPath() {
    return _prefs.getString('rootPath');
  }

  String? getSerzPath() {
    return _prefs.getString('serzPath');
  }

  Future<void> setRailDriverPath(String? railDriverPath) async {
    await _prefs.setString('railDriverPath', railDriverPath);

    final rootPath = await getRootPath();
    if (rootPath != null) {
      _client = TrainSimulatorClient(
        rootPath: rootPath,
        railDriverPath: railDriverPath,
        serzPath: getSerzPath(),
      );
    }

    notifyListeners();
  }

  Future<void> setRootPath(String? rootPath) async {
    await _prefs.setString('rootPath', rootPath);

    if (rootPath != null) {
      _client = TrainSimulatorClient(
        rootPath: rootPath,
        railDriverPath: await getRailDriverPath(),
        serzPath: getSerzPath(),
      );
    }

    notifyListeners();
  }

  Future<void> setSerzPath(String? serzPath) async {
    await _prefs.setString('serzPath', serzPath);

    final rootPath = getRootPath();
    if (rootPath != null) {
      _client = TrainSimulatorClient(
        rootPath: rootPath,
        railDriverPath: getRailDriverPath(),
        serzPath: serzPath,
      );
    }

    notifyListeners();
  }
}
