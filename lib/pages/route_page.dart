import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' hide context;
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/states/app_state.dart';
import 'package:train_simulator_utilities/states/router_state.dart';

class RoutePage extends StatefulWidget {
  final Directory directory;

  const RoutePage({
    Key? key,
    required this.directory,
  }) : super(
          key: key,
        );

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late Future<CRouteProperties?> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basename(widget.directory.path)),
      ),
      body: FutureBuilder<CRouteProperties?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final cRouteProperties = snapshot.data;
            if (cRouteProperties != null) {
              final displayName = cRouteProperties
                  .displayName?.localisationCUserLocalisedString?.english
                  ?.toString();
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Display name'),
                    subtitle: displayName != null ? Text(displayName) : null,
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Scenarios'),
                    onTap: () {
                      RouterState.of(context)?.path = ScenariosRoutePath(
                        directory: widget.directory,
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('No route found.'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future = AppState.of(context)!
        .client!
        .routes
        .readRouteProperties(widget.directory);
  }
}
