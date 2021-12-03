import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Providers/product_provider.dart';
import 'package:flutterapp/Views/Widgets/elev_button.dart';
import 'package:provider/provider.dart';

class AddProductDrawer extends StatefulWidget {
  const AddProductDrawer({Key? key}) : super(key: key);

  @override
  State<AddProductDrawer> createState() => _AddProductDrawerState();
}

class _AddProductDrawerState extends State<AddProductDrawer> {
  late final Product _newProduct = Product.empty();
  Product? _editProduct;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _editProduct =
          Provider.of<ProductProvider>(context, listen: false).productToEdit;
      if (_editProduct != null) {
        nameController = TextEditingController(text: _editProduct!.name);
        descController = TextEditingController(text: _editProduct!.description);
        imageController = TextEditingController(text: _editProduct!.image);
        priceController =
            TextEditingController(text: _editProduct!.price.toString());
        setState(() {});
      }
    });
  }

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
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (value) {
                if (_editProduct == null) {
                  _newProduct.name = value;
                } else {
                  _editProduct!.name = value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onChanged: (value) {
                if (_editProduct == null) {
                  _newProduct.description = value;
                } else {
                  _editProduct!.description = value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image Link'),
              onChanged: (value) {
                if (_editProduct == null) {
                  _newProduct.image = value;
                } else {
                  _editProduct!.image = value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price \$'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (_editProduct == null) {
                  _newProduct.price = double.parse(value);
                } else {
                  _editProduct!.price = double.parse(value);
                }
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevButton(
                    text: _editProduct == null ? 'Add Product' : 'Edit',
                    icon: _editProduct == null ? Icons.add : Icons.edit,
                    onPressed: () {
                      if (_editProduct == null) {
                        Provider.of<ProductProvider>(context, listen: false)
                            .addProduct(_newProduct);
                      } else {
                        Provider.of<ProductProvider>(context, listen: false)
                            .editProduct(_editProduct!);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                _editProduct != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ElevButton(
                          text: 'Delete',
                          icon: Icons.delete,
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false)
                                .deleteProduct(_editProduct!);
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
