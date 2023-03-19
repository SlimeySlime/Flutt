// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttuto/quiz.dart';
import 'package:fluttuto/result.dart';
import 'package:fluttuto/widget/chart.dart';
import 'package:fluttuto/widget/transaction.dart';
import 'package:fluttuto/widget/transaction_list.dart';
import 'package:intl/intl.dart';
import './question.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void main() {
  logger.d('Logger Working with it');
  // WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(home: TransactionApp()));
}

class TransactionApp extends StatefulWidget {
  const TransactionApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransactionAppState();
  }
}

class _TransactionAppState extends State<TransactionApp> {
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.cyan,
      Colors.brown,
      Colors.amber,
      Colors.blue,
      Colors.green,
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  late Color _bgColor;

  // const TransactionApp({super.key})
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'initial', amount: 0, date: DateTime.now()),
    Transaction(id: 't12', title: 'initial2', amount: 1, date: DateTime.now()),
    Transaction(id: 't13', title: 'initial3', amount: 2, date: DateTime.now()),
    Transaction(id: 't14', title: 'initial4', amount: 3, date: DateTime.now()),
    Transaction(id: 't15', title: 'initial5', amount: 40, date: DateTime.now()),
    Transaction(id: 't16', title: 'initial6', amount: 50, date: DateTime.now()),
    Transaction(id: 't17', title: 'initial7', amount: 60, date: DateTime.now()),
    Transaction(id: 't18', title: 'initial8', amount: 70, date: DateTime.now()),
    Transaction(id: 't19', title: 'initial9', amount: 80, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'initial10', amount: 90, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'this online lecture',
        amount: 22900,
        date: DateTime.now()),
    Transaction(id: 't3', title: 'breads', amount: 14000, date: DateTime.now()),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String enteredTitle, double enteredAmount, DateTime choosenDate) {
    var title = enteredTitle;
    var amount = enteredAmount;

    if (title.isEmpty || amount.isNaN || amount < 0 || choosenDate == null) {
      // TODO - TOAST message
      return;
    }
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: choosenDate);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      print('deleted list ${_transactions.where((item) => item.id == id)} ');
      _transactions.removeWhere((item) => item.id == id);
    });
  }

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
    final mediaQuery = MediaQuery.of(context);
    var appBar = AppBar(
      title: Text("Hello Flutter App"),
      actions: [
        IconButton(
            onPressed: () => opneAddNewTransaction(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );
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
        // supportedLocales: const [
        //   Locale('kr', 'KR'),
        //   Locale('en', 'US'),
        // ],
        home: Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  // width: 600,
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                ),
                // TransactionInput(addNewTransaction: _addNewTransaction),
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.6,
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
                          itemBuilder: (context, index) => true
                              ? TransactionCard(
                                  key: ValueKey(_transactions[index].id),
                                  transactionInfo: _transactions[index],
                                  transactionDelete: _deleteTransaction,
                                )
                              : ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _bgColor,
                                    radius: 50,
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: FittedBox(
                                          child: Text(
                                              '${_transactions[index].amount}'),
                                        )),
                                  ),
                                  title: Text(
                                    _transactions[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    DateFormat.yMMM()
                                        .format((_transactions[index].date)),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () => _deleteTransaction(
                                        _transactions[index].id),
                                  ),
                                ),
                        ),
                )
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
