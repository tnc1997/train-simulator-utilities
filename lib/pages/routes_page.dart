import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:path/path.dart' hide context;
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/route_paths/route_route_path.dart';
import 'package:train_simulator_utilities/search_delegates/route_search_delegate.dart';
import 'package:train_simulator_utilities/states/app_state.dart';
import 'package:train_simulator_utilities/states/router_state.dart';
import 'package:train_simulator_utilities/widgets/app_drawer.dart';
import 'package:tuple/tuple.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  late Future<List<Tuple2<Directory, CRouteProperties?>>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.magnify),
            onPressed: () async {
              final directory = await showSearch(
                context: context,
                delegate: RouteSearchDelegate(),
              );

              if (directory != null) {
                RouterState.of(context)?.path = RouteRoutePath(
                  directory: directory,
                );
              }
            },
            tooltip: 'Search',
          ),
        ],
      ),
      body: FutureBuilder<List<Tuple2<Directory, CRouteProperties?>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final tuples = snapshot.data;
            if (tuples != null) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tuples[index]
                              .item2
                              ?.displayName
                              ?.localisationCUserLocalisedString
                              ?.english
                              ?.toString() ??
                          'Unknown',
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      basename(tuples[index].item1.path),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      RouterState.of(context)?.path = RouteRoutePath(
                        directory: tuples[index].item1,
                      );
                    },
                  );
                },
                itemCount: tuples.length,
              );
            } else {
              return Center(
                child: Text('No routes found.'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routes = AppState.of(context)!.client!.routes;
    _future = routes
        .list()
        .asyncMap((directory) async => Tuple2(
              directory,
              await routes.readRouteProperties(directory),
            ))
        .toList();
  }
}
