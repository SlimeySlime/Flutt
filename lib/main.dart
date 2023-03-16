// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttuto/quiz.dart';
import 'package:fluttuto/result.dart';
import 'package:fluttuto/widget/chart.dart';
import 'package:fluttuto/widget/transaction.dart';
import 'package:fluttuto/widget/transaction_list.dart';
import './question.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void main() {
  logger.d('Logger Working with it');
  runApp(MaterialApp(home: QuestionApp()));
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
    // Transaction(id: 't1', title: 'initial', amount: 0, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'this online lecture',
    //     amount: 22900,
    //     date: DateTime.now()),
    // Transaction(id: 't3', title: 'breads', amount: 14000, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String enteredTitle, double enteredAmount) {
    var title = enteredTitle;
    var amount = enteredAmount;

    if (title.isEmpty || amount.isNaN || amount <= 0) {
      // TODO - TOAST message
      return;
    }
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _showToast(BuildContext context, String toastMessage) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(toastMessage),
      action: SnackBarAction(
        label: "SNAKCS",
        onPressed: () {},
      ),
    ));
  }

  void opneAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () => {},
            behavior: HitTestBehavior.opaque,
            child: TransactionInput(addNewTransaction: _addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Tutoring",
        theme: ThemeData(
            // primaryColor: Colors.green,
            primarySwatch: Colors.green,
            fontFamily: 'Nanum',
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          appBar: AppBar(
            title: Text("Hello Flutter App"),
            actions: [
              IconButton(
                  onPressed: () => opneAddNewTransaction(context),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  width: 600,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                ),
                // TransactionInput(addNewTransaction: _addNewTransaction),
                SizedBox(
                  height: 300,
                  child: _transactions.isEmpty
                      ? Column(
                          children: [
                            const Text('No Transaction added yet'),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              height: 100,
                              child: Image.asset(
                                'assets/image/note.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          itemCount: _transactions.length,
                          itemBuilder: (context, index) => TransactionCard(
                              transactionInfo: _transactions[index])),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => opneAddNewTransaction(context),
          ),
        ));
  }
}
