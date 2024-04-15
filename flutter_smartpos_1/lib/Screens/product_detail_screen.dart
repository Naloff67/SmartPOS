import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:provider/provider.dart';
import '../models/dummy_product.dart';

class productDetails extends StatelessWidget {
  static const routeName = '/product-Details';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findbyId(productId);
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: value.currentTheme.primaryColor,
            title: Text(loadedProduct.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    loadedProduct.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'MYR ${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
