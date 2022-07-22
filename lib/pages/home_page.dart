import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Train Simulator Utilities performs a small range of tasks to help manage Train Simulator.',
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
