import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:train_simulator_utilities/src/route_paths/home_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/routes_route_path.dart';
import 'package:train_simulator_utilities/src/route_paths/settings_route_path.dart';
import 'package:train_simulator_utilities/src/states/app_state.dart';
import 'package:train_simulator_utilities/src/states/router_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text('Train Simulator Utilities'),
          ),
          ListTile(
            leading: Icon(Mdi.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              RouterState.of(context).path = const HomeRoutePath();
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Mdi.routes),
            title: Text('Routes'),
            enabled: AppState.of(context).client != null,
            onTap: () {
              Navigator.of(context).pop();
              RouterState.of(context).path = const RoutesRoutePath();
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Mdi.help),
            title: Text('About'),
            onTap: () async {
              showAboutDialog(
                context: context,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.cog),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              RouterState.of(context).path = const SettingsRoutePath();
            },
          ),
        ],
      ),
    );
  }
}
