
import 'package:alpit_portfolio/project_lookup.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(HelloWorld());
}

class HelloWorld extends StatelessWidget{
  const HelloWorld({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProjectLookup()));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Builder(builder: (context){
            return Column(
              children: [
                Text("Hello World!!"),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Button is Clicked")));
                }, child: Text("Click Me!"))
              ],
            );
          }),
        ),
      ),
    );
  }
}

