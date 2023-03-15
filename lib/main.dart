// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttuto/quiz.dart';
import 'package:fluttuto/result.dart';
import 'package:fluttuto/transaction_list.dart';
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

  void _addNewTransaction() {
    log('check the transaction');
    var title = titleController.text;
    var amount = double.parse(amountController.text);

    if (title.isEmpty || amount.isNaN || amount <= 0) {
      log('didnt added for reason');
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
      log('succesfully added');
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

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Text('hello im testing bottom sheet');
        });
  }

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
            actions: const [
              IconButton(
                  onPressed: null,
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
                  width: 300,
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Chart - - -'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onSubmitted: (_) => _addNewTransaction(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // toast(context, amountController.text);
                          _addNewTransaction();
                        },
                        child: Text('Save'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
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
            onPressed: () => startAddNewTransaction(context),
          ),
        ));
  }
}
