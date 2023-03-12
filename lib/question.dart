import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  var questionText;

  Question({super.key, required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String _answer_Text;
  // final Function _selectHandler;
  final VoidCallback _selectHandler;

  Answer(this._answer_Text, this._selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: ElevatedButton(
          onPressed: _selectHandler, // for now
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          child: Text(_answer_Text),
        ));
  }
}
