import 'package:flutter/material.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/src/route_paths/scenarios_route_path.dart';
import 'package:train_simulator_utilities/src/states/app_state.dart';
import 'package:train_simulator_utilities/src/states/router_state.dart';

class RoutePage extends StatefulWidget {
  final String routeId;

  const RoutePage({
    Key key,
    @required this.routeId,
  }) : super(
          key: key,
        );

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  Future<CRouteProperties> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routeId),
      ),
      body: FutureBuilder<CRouteProperties>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Display name'),
                  subtitle: Text(
                    snapshot.data.displayName.localisationCUserLocalisedString
                        .english
                        .toString(),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Scenarios'),
                  onTap: () {
                    RouterState.of(context).path = ScenariosRoutePath(
                      routeId: widget.routeId,
                    );
                  },
                ),
              ],
            );
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
    _future = AppState.of(context).client.route(widget.routeId).get();
  }
}
