import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/product_provider.dart';
import 'Views/Screens/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
