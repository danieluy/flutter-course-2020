import 'package:flutter/material.dart';
import 'result.dart';
import 'quiz.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final String _appTitle = 'Some questions';
  final _questions = [
    {
      'question': 'What\'s you favorite food?',
      'answers': [
        {'text': 'Pizza', 'score': 1},
        {'text': 'Hamburger', 'score': 2},
      ],
    },
    {
      'question': 'What\'s you favorite color?',
      'answers': [
        {'text': 'Red', 'score': 3},
        {'text': 'Green', 'score': 4},
        {'text': 'Blue', 'score': 5},
      ],
    },
    {
      'question': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Dog', 'score': 6},
        {'text': 'Cat', 'score': 7},
        {'text': 'Mouse', 'score': 8},
      ],
    },
  ];
  int _qIdx = 0;
  int _score = 0;

  void _handlePress(int score) {
    setState(() {
      _qIdx += 1;
      _score += score;
    });
  }

  void _handleReset() {
    setState(() {
      _qIdx = 0;
      _score = 0;
    });
  }

  bool _doneWithQuestions() {
    return _qIdx == _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appTitle),
        ),
        body: !_doneWithQuestions()
            ? Quiz(
                onPressed: _handlePress,
                question: _questions[_qIdx],
              )
            : Result(
                score: _score,
                onPressed: _handleReset,
              ),
      ),
    );
  }
}
