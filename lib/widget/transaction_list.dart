import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  late String id;
  late String title;
  late double amount;
  late DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

class TransactionCard extends StatefulWidget {
  final Transaction transactionInfo;
  final Function transactionDelete;

  const TransactionCard(
      {super.key,
      required this.transactionInfo,
      required this.transactionDelete});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
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

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'ko_KR';

    return Card(
      key: widget.key,
      elevation: 5,
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      // color: Theme.of(context).primaryColorDark, width: 2)),
                      color: _bgColor)),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              child: Text(
                '\$ ${widget.transactionInfo.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight:
                      FontWeight.lerp(FontWeight.w100, FontWeight.w800, 2),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.transactionInfo.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  // transactionInfo.date.toString(),
                  DateFormat().format(widget.transactionInfo.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () =>
                    widget.transactionDelete(widget.transactionInfo.id),
                child: const Icon(Icons.delete)),
          ]),
    );
  }
}
