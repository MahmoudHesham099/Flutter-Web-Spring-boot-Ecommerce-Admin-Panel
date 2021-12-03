import 'package:flutter/material.dart';

class ElevButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  final Color? color;
  const ElevButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: color ?? const Color(0xff5b3bfe)),
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10.0,
          ),
          Text(text),
        ],
      ),
    );
  }
}
