import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void increament(){
    setState(() {
      _counter++;
    });
  }

  void decreament(){
    setState(() {
      _counter--;
    });
  }

  void reset(){
    setState(() {
      _counter = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Counter App"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("$_counter", style: TextStyle(fontSize: 50),),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: (){increament();}, child: Text("+")),
          ElevatedButton(onPressed: (){reset();}, child: Text("Reset")),
          ElevatedButton(onPressed: (){decreament();}, child: Text("-"))
        ],
      ),),
    );
  }
}


