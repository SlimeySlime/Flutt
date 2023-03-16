import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class TransactionInput extends StatefulWidget {
  TransactionInput({super.key, required this.addNewTransaction});

  final Function addNewTransaction;

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTransaction() {
    logger.d('submitTransation method in bottom sheet');
    var title = titleController.text;
    var amount = double.parse(amountController.text);

    widget.addNewTransaction(title, amount);

    Navigator.of(context).pop(); // 뒤로가기 기능?
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => widget.addNewTransaction,
          ),
          ElevatedButton(
            onPressed: () => submitTransaction(),
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
