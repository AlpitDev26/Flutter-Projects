import 'package:flutter/material.dart';

void scaffoldProvider(BuildContext context, wasAdded) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        wasAdded
            ? "Meal is Added to Favorites...."
            : "Meal is Removed from Favorites....",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      elevation: 2,
      backgroundColor: wasAdded ? Colors.green : Colors.red,
    ),
  );
}