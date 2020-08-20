import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';
import './chart-bar.dart';

class DailyTr {
  String day;
  double amount;

  DailyTr(this.day, this.amount);

  @override
  String toString() {
    return '$day ${amount.toString()}';
  }
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<DailyTr> get _weeklyTransactions {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        final trDate = recentTransactions[i].date;
        bool sameYear = trDate.year == date.year;
        bool sameMonth = trDate.month == date.month;
        bool sameDay = trDate.day == date.day;
        if (sameYear && sameMonth && sameDay) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return DailyTr(DateFormat.E().format(date).substring(0, 1), totalAmount);
    }).reversed.toList();
  }

  double get _weeklyTotal {
    return _weeklyTransactions.fold(
      0.0,
      (sum, dailytTr) => (sum + dailytTr.amount),
    );
  }

  double _getPorcentage(double amount, double total) {
    if (amount == 0) {
      return 0;
    }
    return amount / total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _weeklyTransactions
              .map((dailyTr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      dailyTr.day,
                      dailyTr.amount,
                      _getPorcentage(dailyTr.amount, _weeklyTotal),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
