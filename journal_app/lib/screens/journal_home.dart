import 'package:flutter/material.dart';
import 'package:journal_app/data/data.dart';

import '../widgets/journal_card.dart';
import '../widgets/journal_input_screen.dart';

class JournalHomeScreen extends StatefulWidget {
  const JournalHomeScreen({super.key});

  @override
  State<JournalHomeScreen> createState() => _JournalHomeScreenState();
}

class _JournalHomeScreenState extends State<JournalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Daily Thoughts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: journalData.length,
        itemBuilder: (context, index) {
          return JournalCard(entry: journalData[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            context: context,
            builder: (context) {
              return InputDataScreen(onSave: (entry) {
                setState(() {
                  journalData.add(entry);
                  print(entry);
                });
              });
            },
          );
        },
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
