import 'dart:io';
import 'package:flutter/material.dart';
import '../config.dart';
import '../models/Transaction.dart';
import './chart.dart';
import './transaction-form.dart';
import './transaction-list.dart';

class Home extends StatefulWidget {
  final BoxConstraints constraints;

  Home(this.constraints);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      amount: 69.99,
      date: DateTime.now(),
      title: 'Shoes',
    ),
    Transaction(
      id: 't2',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 1)),
      title: 'Groceries',
    ),
  ];

  void _handleAddTransaction(String title, double amount, DateTime date) {
    final tr = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(tr);
    });
  }

  void _handleDeleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openTransanctionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionForm(onSubmit: _handleAddTransaction),
    );
  }

  List<Transaction> get _lastWeekTransactions {
    DateTime aWeekAgo = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tr) => tr.date.isAfter(aWeekAgo)).toList();
  }

  Widget get fav {
    if (Platform.isAndroid) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransanctionForm(context),
      );
    }
    return Container();
  }

  List<Widget> get addTransactionAction {
    if (Platform.isIOS) {
      return [
        IconButton(
          tooltip: 'Add transaction',
          icon: Icon(Icons.add),
          onPressed: () => _openTransanctionForm(context),
        ),
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(APP_TITLE),
      actions: addTransactionAction,
    );

    final height = widget.constraints.maxHeight;
    final width = widget.constraints.maxWidth;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBarHeight = appBar.preferredSize.height;
    final bodyHeight = height - appBarHeight;
    final chartHeight = bodyHeight * 0.3;
    final transactionsListHeight = bodyHeight * 0.7;

    final chartContainer = Container(
      height: isLandscape ? bodyHeight : chartHeight,
      width: isLandscape ? width / 2 : double.infinity,
      padding: EdgeInsets.all(8),
      child: Chart(_lastWeekTransactions),
    );

    final transactionsListContainer = Container(
      height: isLandscape ? bodyHeight : transactionsListHeight,
      width: isLandscape ? width / 2 : double.infinity,
      padding: EdgeInsets.all(8),
      child: TransactionList(
        _transactions,
        onDeleteItem: _handleDeleteTransaction,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: !isLandscape
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                chartContainer,
                transactionsListContainer,
              ],
            )
          : Row(
              children: [
                chartContainer,
                transactionsListContainer,
              ],
            ),
      floatingActionButton: fav,
    );
  }
}
