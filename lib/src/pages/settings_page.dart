import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/src/widgets/app_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: AppDrawer(),
    );
  }
}
