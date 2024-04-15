import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smartpos_1/Screens/product_detail_screen.dart';
import 'package:flutter_smartpos_1/models/dummy_product.dart';
import 'Screens/EditImageUrlScreen.dart';
import 'Screens/Landing_screen.dart';
import 'Screens/Product_screen.dart';
import 'Screens/analytic_screen.dart';
import 'Screens/carts_screen.dart';
import 'Screens/orders_screen.dart';
import 'Screens/settings_screen.dart';
import 'Screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/orders.dart';
import 'login/login_page.dart';
import 'models/profileprovider.dart';
import 'models/themenotifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProfileProvider(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.currentTheme,
            home: LoginPage(),
            routes: {
              Landing.routeName: (ctx) => Landing(),
              ProductScreen.routeName: (ctx) => ProductScreen(),
              analyticScreen.routeName: (ctx) => analyticScreen(),
              settingsScreen.routeName: (ctx) => settingsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              productDetails.routeName: (ctx) => productDetails(),
              LoginPage.routeName: (ctx) => LoginPage(),
              EditImageUrlScreen.routeName: (ctx) => EditImageUrlScreen(),
            },
          );
        },
      ),
    );
  }
}
