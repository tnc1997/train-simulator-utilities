import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:train_simulator_client/train_simulator_client.dart';
import 'package:train_simulator_utilities/src/states/app_state.dart';

class RouteSearchDelegate extends SearchDelegate<CRouteProperties> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Mdi.close),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        tooltip: 'Clear',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<CRouteProperties>>(
      future: AppState.of(context)
          .client
          .routes()
          .get()
          .where((cRouteProperties) => cRouteProperties
              .displayName.localisationCUserLocalisedString.english
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data[index].displayName
                      .localisationCUserLocalisedString.english
                      .toString(),
                ),
                onTap: () {
                  close(context, snapshot.data[index]);
                },
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView();
  }
}
