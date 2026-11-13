import 'package:flutter/material.dart';

class ItemTrait extends StatelessWidget {
  final String text;
  final IconData icon;

  const ItemTrait({required this.text, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 2,),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
