import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_simulator_utilities/src/states/app_state.dart';
import 'package:train_simulator_utilities/src/widgets/app_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Builder(
            builder: (context) {
              _controller.text = AppState.of(context).path;
              return ListTile(
                title: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Path',
                    hintText:
                        'C:\\Program Files (x86)\\Steam\\steamapps\\common\\RailWorks',
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Mdi.contentSave),
                  onPressed: () async {
                    final preferences = await SharedPreferences.getInstance();
                    await preferences.setString('path', _controller.text);

                    AppState.of(context).path = _controller.text;
                  },
                  tooltip: 'Save',
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
}
