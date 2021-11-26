import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp/Modules/event.dart';

class EventContainer extends StatelessWidget {
  final Event event;
  const EventContainer({Key? key, required this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 210,
          width: 300,
          child: ClipRRect(
            child: Image.asset(
              event.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          event.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          event.date,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
