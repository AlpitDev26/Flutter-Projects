import 'package:flutter/material.dart';

void main(){
  runApp(MessageDisplay());
}

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayPage(),
    );
  }
}

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final TextEditingController _controller = TextEditingController();
  var displayMessage = '';

  void showMessage(){
    setState(() {
      displayMessage = _controller.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter & Show Message"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
            decoration: InputDecoration(
              labelText: "Enter your message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: (){showMessage();}, child: Text("Show Message")),
            SizedBox(height: 25,),
            Text(displayMessage, style: TextStyle(fontSize: 24, color: Colors.blue),)
          ],
        ),
      ),
    );
  }
}
