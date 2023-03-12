// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import './question.dart';

void main() {
  runApp(QuestionApp());
}

class QuestionApp extends StatefulWidget {
  const QuestionApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionAppState();
  }
}

class _QuestionAppState extends State<QuestionApp> {
  // const QuestionApp({super.key})
  var _question_index = 0;

  // var _questions = [
  //   'What\'s your favorite Color?',
  //   'What\'s your favorite Animal? ',
  // ];
  final _questions = [
    {
      'questionText': 'What\'s your favorite Color?',
      'answers': [
        'Red',
        'Green',
        'Blue',
        'Pink',
        'Yellow',
        'Rainbow',
        'Black',
        'White'
      ]
    },
    {
      'questionText': 'What\'s your favorite Animal?',
      'answers': ['Dog', 'Cat', 'Hamster', 'Bird', 'Platypus']
    },
    {
      'questionText': 'What\'s your most value ?',
      'answers': ['Fame', 'Right', 'Money', 'Power', 'Goodness']
    }
  ];

  void _answerQuestion({int index = 1}) {
    // print('Answer Choosen! $index');
    setState(() {
      if (_question_index < _questions.length - 1) _question_index += 1;
      log('Question Index : $_question_index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Hello Flutter"),
      ),
      body: Column(
        children: [
          Question(
            questionText: _questions[_question_index]['questionText'],
          ),
          ...(_questions[_question_index]['answers'] as List<String>)
              .map((answer) {
            return Answer(answer, _answerQuestion);
          })
          // Answer("Answer3", _answerQuestion),
        ],
      ),
    ));
  }
}
