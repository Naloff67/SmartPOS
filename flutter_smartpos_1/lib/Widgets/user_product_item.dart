import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/edit_product_screen.dart';
import '../models/dummy_product.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(title),
            leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
            trailing: Container(
              width: 100,
              child: Row(children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
              ]),
            ),
          ),
        ),
        Divider(
          height: 5,
          thickness: 2,
        ),
      ],
    );
  }
}
