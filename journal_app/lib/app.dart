import 'package:flutter/material.dart';
import 'package:journal_app/screens/journal_home.dart';

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Journal App",
      debugShowCheckedModeBanner: false,
      home: const JournalHomeScreen(),
    );
  }
}
