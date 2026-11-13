import 'package:flutter/material.dart';
import 'package:random_quote_generator/screens/home_screen.dart';

class Random_Quote_Gen extends StatelessWidget {
  const Random_Quote_Gen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blueGrey,
      title: "Random Quote Generator",
      home: QuoteScreen(),
    );
  }
}
