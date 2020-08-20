import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Products.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool _showFavoritesOnly;

  ProductGrid(this._showFavoritesOnly);

  @override
  Widget build(BuildContext context) {
    final productsProv = Provider.of<Products>(context);
    final products =
        _showFavoritesOnly ? productsProv.favoriteItems : productsProv.items;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
