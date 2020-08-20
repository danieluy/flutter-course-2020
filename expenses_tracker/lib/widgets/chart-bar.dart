import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double amount;
  final double percentage;

  ChartBar(this.dayLabel, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final dividerHeight = 4.0;
        final textHeight = 16.0;
        final graphicHeight = height - (dividerHeight * 2) - (textHeight * 2);
        return Column(
          children: [
            Container(
              height: textHeight,
              child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: dividerHeight),
            Container(
              height: graphicHeight,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: dividerHeight),
            Container(
              height: textHeight,
              child: Text(dayLabel),
            ),
          ],
        );
      },
    );
  }
}
