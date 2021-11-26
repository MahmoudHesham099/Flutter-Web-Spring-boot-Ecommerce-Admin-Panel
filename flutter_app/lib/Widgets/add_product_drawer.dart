import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Modules/event.dart';
import 'package:flutterapp/Provider/event_provider.dart';
import 'package:provider/provider.dart';

class AddProductDrawer extends StatelessWidget {
  const AddProductDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Event? event = context.read<EventProvider>().getEventToEdit();
    print(event?.name);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: event?.name,
                decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: event?.about,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: event?.image,
                decoration: const InputDecoration(labelText: 'Image Link')),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: event?.date,
              decoration: const InputDecoration(labelText: 'Price \$'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xff5b3bfe)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Add Product'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
