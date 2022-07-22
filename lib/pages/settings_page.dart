import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:train_simulator_utilities/states/app_state.dart';
import 'package:train_simulator_utilities/widgets/app_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _rootPathController;

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
              return ListTile(
                title: TextField(
                  controller: _rootPathController,
                  decoration: InputDecoration(
                    labelText: 'Root path',
                    hintText:
                        'C:\\Program Files (x86)\\Steam\\steamapps\\common\\RailWorks',
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Mdi.contentSave),
                  onPressed: () async {
                    await AppState.of(context)
                        ?.setRootPath(_rootPathController.text);
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final rootPath = AppState.of(context)?.getRootPath();
    if (rootPath != null) {
      _rootPathController.text = rootPath;
    }
  }

  @override
  void dispose() {
    _rootPathController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _rootPathController = TextEditingController();
  }
}
