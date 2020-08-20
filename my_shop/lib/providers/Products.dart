import 'package:flutter/material.dart';
import 'Product.dart';
import '../dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (product) => product.id == id,
      orElse: () => null,
    );
  }
}
