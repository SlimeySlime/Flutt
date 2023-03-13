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

class TransationCard extends StatelessWidget {
  final Transaction transactionInfo;

  const TransationCard({super.key, required this.transactionInfo});

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'ko_KR';

    return Card(
      child: Row(children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue, width: 1)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          child: Text(
            '\$ ${transactionInfo.amount}',
            style: TextStyle(
              fontWeight: FontWeight.lerp(FontWeight.w100, FontWeight.w800, 2),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transactionInfo.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              // transactionInfo.date.toString(),
              DateFormat('yyyy-MM-dd').format(transactionInfo.date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        )
      ]),
    );
  }
}
