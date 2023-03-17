import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

var logger = Logger();

class TransactionInput extends StatefulWidget {
  TransactionInput({super.key, required this.addNewTransaction});

  final Function addNewTransaction;

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  void _submitTransaction() {
    logger.d('submitTransation method in bottom sheet');
    var title = _titleController.text;
    var amount = double.parse(_amountController.text);

    widget.addNewTransaction(title, amount, _selectedDate);

    Navigator.of(context).pop(); // 뒤로가기 기능?
  }

  void _selectDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
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
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => widget.addNewTransaction,
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date'
                      : 'Picked Date :  ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                TextButton(
                    onPressed: _selectDate,
                    child: const Text('Choose Date',
                        selectionColor: Colors.red,
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _submitTransaction(),
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
