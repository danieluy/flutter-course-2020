import 'package:flutter/material.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../providers/index.dart';

class CartTotalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context, listen: false);
    final cart = Provider.of<Cart>(context);

    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '\$${cart.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            children: [
              FlatButton(
                child: Text('EDIT ORDER'),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('PLACE ORDER'),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  orders.addOrder(cart.items.values.toList(), cart.total);
                  cart.clear();
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.ROUTE_NAME);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
