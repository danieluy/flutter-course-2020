import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function onPressed;

  Result({this.score, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'You\'ve done it!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          Text(
            'Your score is:',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            score.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
          ),
          FlatButton(
            child: Text('Restart quiz'),
            onPressed: onPressed,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
