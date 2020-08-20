import 'package:flutter/material.dart';
import '../layout/main_drawer.dart';
import '../screens/favorites_screen.dart';
import '../screens/categories_screen.dart';

class BottomTabsScreen extends StatefulWidget {
  @override
  _BottomTabsScreenState createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  final _tabs = [
    {'title': 'Meals', 'body': CategoriesScreen()},
    {'title': 'Favorites', 'body': FavoritesScreen()},
  ];

  int _selectedPageIdx = 0;

  void _handleTap(int i) {
    setState(() {
      _selectedPageIdx = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedPageIdx]['title']),
      ),
      drawer: MainDrawer(),
      body: _tabs[_selectedPageIdx]['body'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleTap,
        currentIndex: _selectedPageIdx,
        items: [
          BottomNavigationBarItem(
            title: Text('Meals'),
            icon: Icon(Icons.restaurant),
          ),
          BottomNavigationBarItem(
            title: Text('Favorites'),
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
