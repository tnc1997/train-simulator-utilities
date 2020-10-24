import 'package:flutter/material.dart';
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/src/states/app_state.dart';

class ScenariosPage extends StatefulWidget {
  final String routeId;

  const ScenariosPage({
    Key key,
    @required this.routeId,
  }) : super(
          key: key,
        );

  @override
  _ScenariosPageState createState() => _ScenariosPageState();
}

class _ScenariosPageState extends State<ScenariosPage> {
  Future<List<CScenarioProperties>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scenarios'),
      ),
      body: FutureBuilder<List<CScenarioProperties>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data[index].displayName
                        .localisationCUserLocalisedString.english
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    snapshot.data[index].id1.cGuid.devString.toString(),
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
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future = AppState.of(context)
        .client
        .route(widget.routeId)
        .scenarios()
        .get()
        .toList();
  }
}
