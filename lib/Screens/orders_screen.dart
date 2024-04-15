import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import '../models/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../Widgets/orders_item.dart';
import '../Widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Consumer<ThemeNotifier>(builder: (context, ThemeNotifier, c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeNotifier.currentTheme.primaryColor,
          title: Text('Your Orders'),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, index) => OrderItem(
            ordersData.orders[index],
          ),
        ),
      );
    });
  }
}
