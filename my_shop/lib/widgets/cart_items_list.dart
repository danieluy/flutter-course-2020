import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Cart.dart';

class CartItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final items = cart.items.values.toList();
    final productIds = cart.items.keys.toList();
    final itemCount = cart.uniqueItemCount;
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (_, i) => CartListTile(items[i], productIds[i]),
      ),
    );
  }
}

class CartListTile extends StatelessWidget {
  final CartItem cartItem;
  final String productId;

  CartListTile(this.cartItem, this.productId);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(cartItem.id),
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This operation cannot be undone.'),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(ctx).pop(true),
            ),
          ],
        ),
      ),
      background: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.delete, color: Colors.white),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 8.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Card(
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  cartItem.quantity.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.black12,
              ),
              SizedBox(width: 16.0),
              Text(
                cartItem.title,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Text(
                '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
