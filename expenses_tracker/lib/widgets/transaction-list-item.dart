import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction tr;
  final Function onDelete;

  TransactionListItem(this.tr, {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              '\$${tr.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        tr.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        DateFormat('MMM dd yyyy').format(tr.date),
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
