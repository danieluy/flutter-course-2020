import 'package:flutter/material.dart';
import 'package:my_shop/providers/index.dart';
import 'package:my_shop/screens/index.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ProductFormScreen.ROUTE_NAME);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                UserProductTile(product: products.items[i]),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
