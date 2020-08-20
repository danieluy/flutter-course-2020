import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function onSubmit;

  TransactionForm({this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  DateTime trDate;

  void _handleSubmit() {
    try {
      final title = titleCtrl.text;
      final amount = double.parse(amountCtrl.text);
      if (title.isNotEmpty && amount > 0 && trDate != null) {
        widget.onSubmit(title, amount, trDate);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked != null) {
        setState(() {
          trDate = picked;
        });
      }
    });
  }

  String get _dateLabel {
    if (trDate != null) {
      return DateFormat('MMM dd yyyy').format(trDate);
    }
    return 'No date chosen';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleCtrl,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _handleSubmit(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(child: Text(_dateLabel)),
                    FlatButton(
                      child:
                          Text(trDate == null ? 'Chose date' : 'Change date'),
                      onPressed: () => _openDatePicker(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: FlatButton(
                  child: Text('+ Add Transaction'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _handleSubmit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
