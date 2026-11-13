import 'dart:math';

import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  static const List<String> dice_no = ["1","2","3","4","5","6"];
  int currentIndex = 0;

  void rollDice(){
    setState(() {
      currentIndex = Random().nextInt(dice_no.length);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dice App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.brown[500],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dice_no[currentIndex],
                style: TextStyle(
                  color: Colors.brown[600],
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              rollDice();
              print("Dice is Rolled.......");
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[500],
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
            child: Text(
              "Roll",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
