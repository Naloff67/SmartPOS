import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/Screens/analytic_screen.dart';
import 'package:flutter_smartpos_1/Screens/orders_screen.dart';
import 'package:flutter_smartpos_1/login/login_page.dart';
import '../Screens/Landing_screen.dart';
import '../Screens/Product_screen.dart';
import '../Screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, void Function() taphand) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
      ),
      onTap: taphand,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.amber,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Checkout', Icons.book, () {
            Navigator.of(context).pushNamed(Landing.routeName);
          }),
          Divider(),
          buildListTile('Orders', Icons.payment, () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          }),
          Divider(),
          buildListTile('Product', Icons.production_quantity_limits_sharp, () {
            Navigator.of(context).pushNamed(ProductScreen.routeName);
          }),
          Divider(),
          buildListTile('Analytics', Icons.analytics_outlined, () {
            Navigator.of(context).pushNamed(analyticScreen.routeName);
          }),
          Divider(),
          buildListTile('Settings', Icons.settings, () {
            Navigator.of(context).pushNamed(settingsScreen.routeName);
          }),
          Divider(),
          buildListTile('Logout', Icons.logout, () {
            Navigator.of(context).pushNamed(LoginPage.routeName);
          }),
        ],
      ),
    );
  }
}
