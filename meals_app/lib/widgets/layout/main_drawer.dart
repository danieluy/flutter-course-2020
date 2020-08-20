import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Drawer(
      child: Column(
        children: [
          Logo(),
          NavItem(
            label: 'Meals',
            icon: Icons.restaurant,
            onTap: () => navigator.pushReplacementNamed('/'),
          ),
          NavItem(
            label: 'Settings',
            icon: Icons.settings,
            onTap: () => navigator.pushReplacementNamed('/settings'),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  const NavItem({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 180,
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 8.0),
            Text(
              'DeliMeal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
