import 'package:flutter/material.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../screens/cart_sreen.dart';
import '../providers/Cart.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

enum GRID_FILTER {
  FAVORITES_ONLY,
  SHOW_ALL,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;

  void _handleFilterChange(bool state) {
    setState(() {
      _showFavoritesOnly = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cartProv, child) => Badge(
              child: child,
              value: cartProv.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.ROUTE_NAME);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (GRID_FILTER filter) {
              if (filter == GRID_FILTER.FAVORITES_ONLY) {
                _handleFilterChange(true);
              } else {
                _handleFilterChange(false);
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: GRID_FILTER.FAVORITES_ONLY,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: GRID_FILTER.SHOW_ALL,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showFavoritesOnly),
    );
  }
}
