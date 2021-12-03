import 'package:flutter/material.dart';
import 'package:flutterapp/Providers/product_provider.dart';
import 'package:flutterapp/Views/Widgets/add_product_drawer.dart';
import 'package:flutterapp/Views/Widgets/elev_button.dart';
import 'package:flutterapp/Views/Widgets/product_container.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff5b3bfe),
        title: const Text(
          'Ecommerce Admin Panel 🚀',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: const [SizedBox()],
      ),
      endDrawer: const AddProductDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products 💰',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ElevButton(
                  text: 'Add Product',
                  icon: Icons.add,
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .productToEdit = null;
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 400,
              child: TextField(
//                    controller: _searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintText: 'search products by name...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (input) {},
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ResponsiveGridList(
                desiredItemWidth: 200,
                minSpacing: 20,
                children: Provider.of<ProductProvider>(context)
                    .products
                    .map<Widget>((product) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .productToEdit = product;
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: ProductContainer(product: product),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}