import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'transaction-list-item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function onDeleteItem;

  TransactionList(this._transactions, {this.onDeleteItem});

  Widget itemBuilder(BuildContext ctx, int idx) {
    return TransactionListItem(
      _transactions[idx],
      onDelete: () => onDeleteItem(_transactions[idx].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_transactions.isNotEmpty) {
      return Card(
        elevation: 2,
        child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: _transactions.length,
          // children: _transactions.map((tr) => TransactionCard(tr)).toList(),
        ),
      );
    }
    return Column(
      children: [
        Text(
          'No Transactions',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
