import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercent});

  final String label;
  final double spendingAmount;
  final double spendingPercent;

  @override
  Widget build(BuildContext context) {
    // print('${spendingPercent}, ${spendingAmount} in ${label}');

    return LayoutBuilder(
      builder: (ctx, constraints) => Column(
        children: <Widget>[
          SizedBox(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(child: Text(spendingAmount.toStringAsFixed(0)))),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercent, // for temp
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(child: Text('${label}'))),
        ],
      ),
    );
  }
}
