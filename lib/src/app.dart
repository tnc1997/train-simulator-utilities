import 'package:flutter/material.dart';
import 'package:train_simulator_utilities/src/route_information_parsers/app_route_information_parser.dart';
import 'package:train_simulator_utilities/src/router_delegates/app_router_delegate.dart';
import 'package:train_simulator_utilities/src/states/router_state.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _routeInformationParser = AppRouteInformationParser();

  AppRouterDelegate _routerDelegate;
  RouterStateData _routerState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      title: 'Train Simulator Utilities',
    );
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    _routerState.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _routerState = RouterStateData();
    _routerDelegate = AppRouterDelegate(
      routerState: _routerState,
    );
  }
}
