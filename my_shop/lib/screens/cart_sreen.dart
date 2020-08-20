import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class CartScreen extends StatelessWidget {
  static const ROUTE_NAME = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<Cart>(
        builder: (ctx, cartProvider, child) => Column(
          children: [
            CartTotalCard(),
            CartItemsList(),
          ],
        ),
      ),
    );
  }
}
