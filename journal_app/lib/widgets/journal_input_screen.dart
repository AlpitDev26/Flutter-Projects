import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/data/journal_entry_model.dart';

class InputDataScreen extends StatefulWidget {
  final Function(JournalEntry) onSave;
  const InputDataScreen({super.key, required this.onSave});

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  // text editing controller
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
      child: Container(
        color: Colors.white30,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleEditingController,
              decoration: InputDecoration(
                labelText: "Title",
                hint: Text("Enter the Title here"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _contentEditingController,
              decoration: InputDecoration(
                labelText: "Content",
                hint: Text("Enter the Content here"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    JournalEntry entry = JournalEntry(
                      id: '0',
                      title: _titleEditingController.text,
                      content: _contentEditingController.text,
                      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    );

                    //  State Update
                    // setState(() {
                    //   journalData.add(entry);
                    // });

                    widget.onSave(entry);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
