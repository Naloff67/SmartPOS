import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/orders.dart';
import 'package:intl/intl.dart';
import 'char_bar.dart';

class Chart extends StatelessWidget {
  final List<OrderItem> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTxnVal {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        "days": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    }).toList();
  }

  double get maxSpending {
    return groupedTxnVal.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxnVal.map(
              (Value) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Chart_bar(
                    Value["days"] as String,
                    Value["amount"] as double,
                    maxSpending == 0.0
                        ? 0.0
                        : (Value["amount"] as double) / maxSpending,
                  ),
                );
              },
            ).toList()),
      ),
    );
  }
}
