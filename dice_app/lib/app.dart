import 'package:dice_app/screens/dicescreen.dart';
import 'package:flutter/material.dart';

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Dice App",
      debugShowCheckedModeBanner: false,
      home: DiceScreen(),
    );
  }
}
