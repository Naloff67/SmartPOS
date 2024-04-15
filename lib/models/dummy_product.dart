import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/Product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Ayam Gepuk',
      description: 'one white rice with one chicken and smabal on the side',
      price: 10.20,
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkFyvulw9BqqZdWOgfVxmK_S7LwLig2KFwcRaHjxSFaCMReD7MJLfmv8F9YAI5jbMvaSA&usqp=CAU',
    ),
    Product(
      id: 'p2',
      title: 'Roti Canai',
      description: 'one roti canai with curry dahl and curry fish as the side',
      price: 2.50,
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdhD_euFaIjCt7AOmyNB3xBLXr1v1gpWzY2Q&usqp=CAU',
    ),
    Product(
      id: 'p3',
      title: 'Nasi Kandar',
      description: 'one rice with with kuah campur and one chicken ',
      price: 14.00,
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_6Ne91_nTe6x0_aFQ6T3M3HBgRmQpENHjvHhsuCzgqH_yMuJpHrZRPKtK4sf_MsFmpmw&usqp=CAU',
    ),
    Product(
      id: 'p4',
      title: 'Mee Goreng',
      description:
          ' mee goreng With a sticky, savoury sweet sauce with chicken, prawns, vegetables and signature egg ribbons.',
      price: 7.00,
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6OCIjZs8dnMRL5r5AUHC_twDJ8_PVB_VueQ&usqp=CAU',
    ),
  ];

  List<Product> get items {
    return [..._item];
  }

  Product findbyId(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://smartpos-bd9d4-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageURL': product.imageURL,
          }));
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageURL: product.imageURL,
        id: json.decode(response.body)['name'],
      );
      _item.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _item[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _item.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
