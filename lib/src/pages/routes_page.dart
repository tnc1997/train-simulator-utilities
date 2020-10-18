import 'package:flutter/material.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/src/states/app_state.dart';
import 'package:train_simulator_utilities/src/widgets/app_drawer.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  Future<List<CRouteProperties>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routes'),
      ),
      body: FutureBuilder<List<CRouteProperties>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data[index].id1.cGuid.devString.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    snapshot.data[index].displayName
                        .localisationCUserLocalisedString.english
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
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
    _future = AppState.of(context).client.routes.get().toList();
  }
}
