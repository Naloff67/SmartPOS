import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart' show Cart;
import '../Widgets/cart_item.dart';
import '../models/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Cart'),
            backgroundColor: value.currentTheme.primaryColor,
          ),
          body: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Chip(
                            label: Text(
                              'MYR ${cart.totalamount.toStringAsFixed(2)}',
                            ),
                            backgroundColor: Theme.of(context).primaryColor),
                        TextButton(
                          onPressed: () {
                            if (cart.totalamount == 0.00) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text('Please add item'),
                                ),
                              );
                            } else {
                              Provider.of<Orders>(context, listen: false)
                                  .addOrders(cart.items.values.toList(),
                                      cart.totalamount);
                              cart.clearCart();
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text('Payment Complete !'),
                                ),
                              );
                            }
                          },
                          child: Text('PAY BY CASH'),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title),
              ))
            ],
          ),
        );
      },
    );
  }
}
