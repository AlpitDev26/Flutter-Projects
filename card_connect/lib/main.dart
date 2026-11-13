import 'package:card_connect/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CardConnectApp());
}


class CardConnectApp extends StatelessWidget {
  const CardConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
