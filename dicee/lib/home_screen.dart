import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Text(
          "DICEE",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, fontFamily: 'Pangolin'),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/dice_1.png')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/dice_2.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
