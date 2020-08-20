import 'package:flutter/material.dart';
import 'theme.dart';
import './widgets/screens/meal_detail_screen.dart';
import './widgets/screens/categoy_meals_screen.dart';
// import './widgets/screens/tabs_screen.dart';
import './widgets/layout/bottom_tabs_screen.dart';
import './widgets/screens/settings_screen.dart';
import './models/Filter.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Filter> _filters = [
    Filter('Gluten Free', false),
    Filter('Vegetarian', false),
    Filter('Vegan', false),
    Filter('Lactose Free', false),
  ];

  void _handleFilterUpdate(Filter filter, bool newState) {
    setState(() {
      _filters = _filters.map((_filter) {
        final newFilter = Filter.fromExisting(_filter);
        if (_filter.equals(filter)) {
          newFilter.state = newState;
        }
        return newFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: themeData,
      home: BottomTabsScreen(),
      routes: {
        CategoryMealsScreen.ROUTE_NAME: (ctx) {
          return CategoryMealsScreen(filters: _filters);
        },
        MealDetailScreen.ROUTE_NAME: (ctx) => MealDetailScreen(),
        SettingsScreen.ROUTE_NAME: (ctx) {
          return SettingsScreen(
            filters: _filters,
            updateFilter: _handleFilterUpdate,
          );
        },
      },
    );
  }
}
