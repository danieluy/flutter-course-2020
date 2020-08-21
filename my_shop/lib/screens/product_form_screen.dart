import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/providers/index.dart';

class ProductFormScreen extends StatefulWidget {
  static const ROUTE_NAME = '/product-form';

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  Product _prod = Product(
    id: DateTime.now().toString(),
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _handleSubmit() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      print(_prod.title);
      print(_prod.description);
      print(_prod.imageUrl);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prod = Product(
                      id: _prod.id,
                      title: value,
                      description: _prod.description,
                      imageUrl: _prod.imageUrl,
                      price: _prod.price,
                    );
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prod = Product(
                      id: _prod.id,
                      title: _prod.title,
                      description: _prod.description,
                      imageUrl: _prod.imageUrl,
                      price: double.parse(value),
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prod = Product(
                      id: _prod.id,
                      title: _prod.title,
                      description: value,
                      imageUrl: _prod.imageUrl,
                      price: _prod.price,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 16, right: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (value) => _handleSubmit(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _prod = Product(
                            id: _prod.id,
                            title: _prod.title,
                            description: _prod.description,
                            imageUrl: value,
                            price: _prod.price,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: _handleSubmit,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
