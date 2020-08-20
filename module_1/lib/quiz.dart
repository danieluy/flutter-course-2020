import 'package:flutter/material.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final Map<String, Object> question;
  final Function onPressed;

  Quiz({
    @required this.question,
    @required this.onPressed,
  });

  List<Container> _renderAnwers(List<Map<String, Object>> questions) {
    return questions
        .map(
          (answer) => Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(answer['text']),
              onPressed: () => onPressed(answer['score']),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question['question']),
        ..._renderAnwers(question['answers']),
      ],
    );
  }
}
