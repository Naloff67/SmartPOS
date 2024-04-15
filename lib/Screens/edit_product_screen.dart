import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import '../models/Product.dart';
import 'package:provider/provider.dart';
import '../models/dummy_product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageURL: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };

  var _isinit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productId = ModalRoute.of(context)?.settings.arguments;

      if (productId != null && productId is String) {
        _editedProduct = Provider.of<Products>(context).findbyId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageURL': '',
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    setState(() {});
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occured!'),
                  content: Text(error.toString()),
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Okay'))
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: value.currentTheme.primaryColor,
              title: const Text('Edit Product'),
              actions: <Widget>[
                IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
              ],
            ),
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(
                                  top: 8,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: _imageUrlController.text.isEmpty
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text('Enter a URL'))
                                    : FittedBox(
                                        child: Image.network(
                                          _imageUrlController.text,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: _initValues['title'],
                            decoration: InputDecoration(labelText: 'Title'),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please provide a title';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: value ?? '',
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageURL: _editedProduct.imageURL,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['price'],
                            decoration: InputDecoration(labelText: 'Price'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please provide a price';
                              }

                              if (double.tryParse(value!) == null) {
                                return 'Please provide a price';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Please enter a number greater than zero';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: double.parse(value ?? '0'),
                                description: _editedProduct.description,
                                imageURL: _editedProduct.imageURL,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['description'],
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descriptionFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a description';
                              }
                              if (value.length < 10) {
                                return 'Please enter more than 10 character';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: value!,
                                imageURL: _editedProduct.imageURL,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'ImageURL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onChanged: (_) => _updateImageUrl(),
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) => {_saveForm()},
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter an image URL';
                              }
                              if (!(value!.startsWith('http') ||
                                  !value.startsWith('https'))) {
                                return 'Please enter an valid URL';
                              }
                              if (!(value.endsWith('.png') ||
                                  !value.endsWith('.jpg') ||
                                  !value.endsWith('.jpeg'))) {
                                return 'Please enter a valid image URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageURL: value ?? '',
                                id: _editedProduct.id,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
