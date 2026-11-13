import 'package:flutter/material.dart';
import 'package:trupti_roadlines/screens/loginscreen.dart';

void main(){
  runApp(TruptiRdApp());
}


class TruptiRdApp extends StatelessWidget {
  const TruptiRdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trupti Roadlines",
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
