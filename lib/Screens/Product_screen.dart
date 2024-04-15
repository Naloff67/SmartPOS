import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import '../Widgets/main_drawer.dart';
import '../models/dummy_product.dart';
import '../Widgets/user_product_item.dart';
import '../Screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/Product';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: value.currentTheme.primaryColor,
            title: Text('Products'),
            actions: <Widget>[
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName),
                  icon: Icon(Icons.add))
            ],
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(10),
            itemBuilder: (ctx, index) => UserProductItem(
              productsData.items[index].id ?? '',
              productsData.items[index].title,
              productsData.items[index].imageURL,
            ),
            itemCount: productsData.items.length,
          ),
        );
      },
    );
  }
}
