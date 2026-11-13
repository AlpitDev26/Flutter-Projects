import 'dart:math';
import 'package:flutter/material.dart';
import '../data/quotes.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int current_index = 0;

  void _generate_quote() {
    setState(() {
      current_index = Random().nextInt(quotes.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
        title: Text(
          "Random Quote Generator",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                ' "${quotes[current_index]["quote"]!}" ',
                style: TextStyle(
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '-- ${quotes[current_index]["author"]!} ',
                style: TextStyle(fontSize: 18,
                    color: Colors.yellow,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {
                  _generate_quote();
                  print(
                    "------------Inspired You(CHAL CHAL CHAl.........)------------",
                  );
                },
                child: Text("Inspire ME!", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
