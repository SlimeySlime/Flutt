// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttuto/quiz.dart';
import 'package:fluttuto/result.dart';
import 'package:fluttuto/transaction.dart';
import './question.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'initial', amount: 0, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'this online lecture',
        amount: 22900,
        date: DateTime.now()),
    Transaction(id: 't3', title: 'breads', amount: 14000, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Tutoring",
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
            appBar: AppBar(
              title: Text("Hello Flutter App"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  width: 300,
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Chart - - -'),
                    ),
                  ),
                ),
                Column(
                  children: _transactions
                      .map((e) => TransationCard(
                            transactionInfo: e,
                          ))
                      .toList(),
                ),
              ],
            )));
  }
}
