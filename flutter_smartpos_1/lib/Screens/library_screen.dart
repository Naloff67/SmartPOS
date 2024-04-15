import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/product_items.dart';
import '../models/dummy_product.dart';

class libraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: productsData.items[index],
          child: productItem(),
        ),
        itemCount: productsData.items.length,
      ),
    );
  }
}
