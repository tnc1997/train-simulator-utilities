import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_simulator_client/train_simulator_client.dart';
import 'package:train_simulator_utilities/src/app.dart';
import 'package:train_simulator_utilities/src/states/app_state.dart';

Future<void> main() async {
  TrainSimulatorClient client;
  final preferences = await SharedPreferences.getInstance();
  final path = preferences.getString('path');
  if (path != null) {
    client = TrainSimulatorClient(
      options: TrainSimulatorClientOptions(
        path: path,
      ),
    );
  }

  runApp(
    AppState(
      notifier: AppStateData(
        client: client,
        path: path,
      ),
      child: App(),
    ),
  );
}
