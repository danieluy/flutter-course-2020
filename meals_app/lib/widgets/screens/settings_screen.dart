import 'package:flutter/material.dart';
import '../../models/Filter.dart';
import '../layout/main_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/settings';
  final List<Filter> filters;
  final void Function(Filter filter, bool newState) updateFilter;

  SettingsScreen({this.filters, this.updateFilter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filters', style: Theme.of(context).textTheme.headline6),
            Expanded(
              child: ListView(
                children: filters
                    .map(
                      (Filter filter) => SwitchListTile(
                        title: Text(filter.description),
                        subtitle: Text(
                          'Only include ${filter.description.toLowerCase()} meals.',
                        ),
                        value: filter.state,
                        onChanged: (newValue) => updateFilter(filter, newValue),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
