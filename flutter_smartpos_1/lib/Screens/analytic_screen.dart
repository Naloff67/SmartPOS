import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/orders.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:provider/provider.dart';
import '../Widgets/Transactionlist.dart';
import '../Widgets/main_drawer.dart';
import '../Widgets/chart.dart';

class analyticScreen extends StatefulWidget {
  static const routeName = '/Analytics';

  @override
  State<analyticScreen> createState() => _analyticScreenState();
}

class _analyticScreenState extends State<analyticScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    final recentTransactions = ordersData.getRecentTransactions;

    return Consumer<ThemeNotifier>(builder: (context, ThemeNotifier, child) {
      return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: ThemeNotifier.currentTheme.primaryColor,
          title: const Text('Analytics'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransactions),
              ),
              Container(
                child: recentTransactions.isEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: 150.00),
                        child: Text(
                          'No Transaction yet !',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : TransactionList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
