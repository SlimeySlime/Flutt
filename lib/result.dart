import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  Result({super.key, required this.resetFunction});

  VoidCallback resetFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Ok Survey is Over',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: resetFunction, child: const Text("Restart Survey")),
        ],
      ),
    );
  }
}
