import 'package:flutter/material.dart';
import 'package:flutterapp/Provider/event_provider.dart';
import 'package:flutterapp/Widgets/add_product_drawer.dart';
import 'package:flutterapp/Widgets/event_container.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff5b3bfe),
        title: const Text(
          'Ecommerce Admin Panel',
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
                  'Products',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff5b3bfe),
                  ),
                  onPressed: () {
                    context.read<EventProvider>().setEventToEdit(null);
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Add Product'),
                    ],
                  ),
                )
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
                children: Provider.of<EventProvider>(context)
                    .getAllEvents()
                    .map<Widget>((event) {
                  return GestureDetector(
                      onTap: () {
                        context.read<EventProvider>().setEventToEdit(event);
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: EventContainer(event: event));
                }).toList()),
          ),
        ],
      ),
    );
  }
}
