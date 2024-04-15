import 'package:flutter/material.dart';

class Chart_bar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  Chart_bar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraint) {
      return Column(
        children: <Widget>[
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
                child: Text("\$${spendingAmount.toStringAsFixed(0)}")),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 1),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
