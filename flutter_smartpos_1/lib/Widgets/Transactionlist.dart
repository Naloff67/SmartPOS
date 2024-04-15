import 'package:flutter/material.dart';
import '../models/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/orders_item.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txn = Provider.of<Orders>(context);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: txn.orders.length,
        itemBuilder: (context, index) => OrderItem(txn.orders[index]),
      ),
    );
  }
}
