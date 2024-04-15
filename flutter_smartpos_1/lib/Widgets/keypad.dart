import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/key.dart';

class Keypad extends StatefulWidget {
  @override
  State<Keypad> createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String enteredAmount = '';
  List<keyproduct> products = [];

  void addproducts() {
    DateTime date = DateTime.now();
    String productId = DateFormat.ms().format(date);
    String newname = 'Item';
    keyproduct newproduct = keyproduct(
        id: productId, name: newname, price: double.parse(enteredAmount));

    setState(() {
      products.add(newproduct);
      enteredAmount = '';
    });
  }

  void clearEnteredAmount() {
    setState(() {
      enteredAmount = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final totalproduct = <keyproduct>[];
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      keyproduct product = products[index];

                      return Column(
                        children: [
                          ListTile(
                            title: Text('ID: ${product.name} ${index + 1} '),
                            trailing: Text('x 1'),
                            subtitle: Text(
                                'Price: MYR ${product.price.toStringAsFixed(2)}'),
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  products.removeWhere(
                                      (prod) => prod.id == product.id);
                                  // products.remove(product);
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 20,
                      alignment: Alignment.centerRight,
                      child: Text(
                        enteredAmount,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) =>
                                              value.currentTheme.primaryColor)),
                              onPressed: () {
                                if (enteredAmount == '' ||
                                    enteredAmount == '0.00') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Please Insert a valid price"),
                                    duration: Duration(seconds: 1),
                                  ));
                                } else if (enteredAmount != 0) {
                                  addproducts();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Item added"),
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                                ;
                              },
                              child: Text(
                                'Add Item',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            )),
                            VerticalDivider(
                              width: 2,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) =>
                                                  value.currentTheme
                                                      .primaryColor)),
                                  onPressed: () {
                                    if (products.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("No item has been added yet"),
                                        duration: Duration(seconds: 1),
                                      ));
                                    } else {
                                      for (keyproduct product in products) {
                                        cart.addItem(product.id, product.price,
                                            product.name);
                                      }
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text('Added Item to Cart'),
                                        action: SnackBarAction(
                                          label: 'UNDO',
                                          onPressed: () {
                                            for (keyproduct product
                                                in products) {
                                              cart.removeSingleItem(product.id);
                                            }
                                          },
                                        ),
                                      ));

                                      setState(() {
                                        products.clear();
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Charge",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        )),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          enteredAmount += '1';
                                        });
                                      },
                                      child: Text('1'),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          enteredAmount += '4';
                                        });
                                      },
                                      child: Text('4'),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          enteredAmount += '7';
                                        });
                                      },
                                      child: Text('7'),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          clearEnteredAmount();
                                        });
                                      },
                                      child: Text('DEL'),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '2';
                                      });
                                    },
                                    child: Text('2'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '5';
                                      });
                                    },
                                    child: Text('5'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '8';
                                      });
                                    },
                                    child: Text('8'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '0';
                                      });
                                    },
                                    child: Text('0'),
                                  ),
                                ),
                              ]),
                        ),
                        VerticalDivider(),
                        Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '3';
                                      });
                                    },
                                    child: Text('3'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '6';
                                      });
                                    },
                                    child: Text('6'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        enteredAmount += '9';
                                      });
                                    },
                                    child: Text('9'),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      enteredAmount += '.';
                                    },
                                    child: Text('.'),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
