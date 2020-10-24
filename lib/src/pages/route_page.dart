import 'package:flutter/material.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/src/states/app_state.dart';

class RoutePage extends StatefulWidget {
  final String id;

  const RoutePage({
    Key key,
    @required this.id,
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
        title: Text(widget.id),
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
    _future = AppState.of(context).client.routes.getById(widget.id);
  }
}
