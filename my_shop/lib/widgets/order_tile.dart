import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/index.dart';

class OrderTile extends StatefulWidget {
  final OrderItem order;

  OrderTile(this.order);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(!_expanded ? Icons.expand_more : Icons.expand_less),
              onPressed: _toggleExpanded,
            ),
          ),
          if (_expanded)
            Container(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: widget.order.products.map((prod) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${prod.quantity}x \$${prod.price}',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    );
                  }).toList(),
                ),
                height: min(
                  widget.order.products.length * 20.0 + 45.0,
                  180.0,
                )),
        ],
      ),
    );
  }
}
