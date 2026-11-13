import 'package:dicee/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(DiceeApp());
}

class DiceeApp extends StatelessWidget {
  const DiceeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
