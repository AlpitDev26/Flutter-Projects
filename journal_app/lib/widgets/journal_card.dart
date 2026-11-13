import 'package:flutter/material.dart';
import 'package:journal_app/data/journal_entry_model.dart';

class JournalCard extends StatelessWidget {
  final JournalEntry entry;
  const JournalCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amberAccent,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              entry.content,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              entry.date,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
