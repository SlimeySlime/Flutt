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
    print('${spendingPercent}, ${spendingAmount} in ${label}');
    return Column(
      children: [
        FittedBox(child: Text('${spendingAmount.toStringAsFixed(0)}')),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
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
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
        Text('${label}'),
      ],
    );
  }
}
