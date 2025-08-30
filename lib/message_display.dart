
import 'package:alpit_portfolio/project_lookup.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MessageDisplay());
}

class MessageDisplay extends StatelessWidget{
  const MessageDisplay({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: MessageInputApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MessageInputApp extends StatefulWidget {
  const MessageInputApp({super.key});

  @override
  State<MessageInputApp> createState() => _MessageInputAppState();
}

class _MessageInputAppState extends State<MessageInputApp> {
  final TextEditingController _controller = TextEditingController();
  var displayMessage = "";
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
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProjectLookup()));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _controller,
                decoration: InputDecoration(labelText: "Enter Your Message",
                    border: OutlineInputBorder()
                )
            ),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: showMessage, child: Text("Show Message")),
            SizedBox(height: 30,),
            Text(displayMessage,
              style: TextStyle(color: Colors.blue, fontSize: 25),)
          ],
        ),
      ),
    );
  }
}
