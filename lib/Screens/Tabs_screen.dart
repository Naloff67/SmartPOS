import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../Widgets/main_drawer.dart';
import 'library_screen.dart';
import '../Widgets/keypad.dart';
import '../Screens/carts_screen.dart';
import '../Widgets/019 badge.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabscreen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    Keypad(),
    libraryPage(),
  ];
  int _selectPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: ThemeNotifier.currentTheme.primaryColor,
            title: Text('Checkout'),
            actions: <Widget>[
              Consumer<Cart>(
                builder: (_, cart, child) {
                  if (child != null) {
                    return badge(
                      value: cart.itemCount.toString(),
                      child: child,
                    );
                  }
                  return Container();
                },
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    icon: Icon(Icons.shopping_basket)),
              ),
            ],
          ),
          body: _pages[_selectPageIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.amber,
            currentIndex: _selectPageIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).accentColor,
                icon: Icon(
                  Icons.calculate,
                ),
                label: 'Keypad',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_add_check),
                label: 'Library',
              ),
            ],
          ),
        );
      },
    );
  }
}
