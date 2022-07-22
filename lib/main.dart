import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_simulator_utilities/route_information_parsers/app_route_information_parser.dart';
import 'package:train_simulator_utilities/router_delegates/app_router_delegate.dart';
import 'package:train_simulator_utilities/states/app_state.dart';
import 'package:train_simulator_utilities/states/router_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: prefs));
}

class App extends StatefulWidget {
  final SharedPreferences prefs;

  const App({
    Key? key,
    required this.prefs,
  }) : super(
          key: key,
        );

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _routerStateData = RouterStateData();

  late AppStateData _appStateData;
  late AppRouterDelegate _routerDelegate;
  late AppRouteInformationParser _routeInformationParser;

  @override
  Widget build(BuildContext context) {
    return AppState(
      notifier: _appStateData,
      child: RouterState(
        notifier: _routerStateData,
        child: MaterialApp.router(
          routeInformationParser: _routeInformationParser,
          routerDelegate: _routerDelegate,
          title: 'Train Simulator Utilities',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appStateData.dispose();
    _routerDelegate.dispose();
    _routerStateData.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appStateData = AppStateData(
      prefs: widget.prefs,
    );
    _routeInformationParser = AppRouteInformationParser(
      appStateData: _appStateData,
    );
    _routerDelegate = AppRouterDelegate(
      routerStateData: _routerStateData,
    );
  }
}
