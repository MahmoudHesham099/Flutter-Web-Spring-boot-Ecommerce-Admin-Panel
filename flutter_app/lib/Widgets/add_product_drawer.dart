import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductDrawer extends StatefulWidget {
  const AddProductDrawer({Key? key}) : super(key: key);

  @override
  State<AddProductDrawer> createState() => _AddProductDrawerState();
}

class _AddProductDrawerState extends State<AddProductDrawer> {
  late final Product _newProduct = Product.empty();
  Product? _editProduct;
//  @override
//  void initState() {
//    super.initState();
//    _editProduct = context.read<ProductProvider>().getProductToEdit();
//  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Text(
              _editProduct == null ? 'Add Product' : 'Edit Product',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _editProduct?.name,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                _newProduct.name = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _editProduct?.description,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onChanged: (value) {
                _newProduct.description = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _editProduct?.image,
              decoration: const InputDecoration(labelText: 'Image Link'),
              onChanged: (value) {
                _newProduct.image = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _editProduct?.price.toString(),
              decoration: const InputDecoration(labelText: 'Price \$'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _newProduct.price = double.parse(value);
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xff5b3bfe)),
              onPressed: () {
                if (_editProduct == null) {
                  context.read<ProductProvider>().addProduct(_newProduct);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(_editProduct == null ? 'Add Product' : 'Edit Product'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
