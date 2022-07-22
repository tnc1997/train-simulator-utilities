import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' hide context;
import 'package:train_simulator_client/train_simulator_client.dart' hide Key;
import 'package:train_simulator_utilities/states/app_state.dart';
import 'package:tuple/tuple.dart';

class ScenariosPage extends StatefulWidget {
  final Directory directory;

  const ScenariosPage({
    Key? key,
    required this.directory,
  }) : super(
          key: key,
        );

  @override
  _ScenariosPageState createState() => _ScenariosPageState();
}

class _ScenariosPageState extends State<ScenariosPage> {
  late Future<List<Tuple2<Directory, CScenarioProperties?>>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scenarios'),
      ),
      body: FutureBuilder<List<Tuple2<Directory, CScenarioProperties?>>>(
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
                  );
                },
                itemCount: tuples.length,
              );
            } else {
              return Center(
                child: Text('No scenarios found.'),
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
    final client = AppState.of(context)!.client!;
    _future = client.routes
        .listScenarios(widget.directory)
        .asyncMap((directory) async => Tuple2(
              directory,
              await client.scenarios.readScenarioProperties(directory),
            ))
        .toList();
  }
}
