import 'package:alpit_portfolio/message_display.dart';
import 'package:alpit_portfolio/product_list_login.dart';
import 'package:alpit_portfolio/profile_page.dart';
import 'package:alpit_portfolio/studentRegistrationForm.dart';
import 'package:flutter/material.dart';

import 'hello_world.dart';

class ProjectLookup extends StatelessWidget {

  final List<Map<String, dynamic>> projects = [
    {'name': 'Hello World'},
    {'name': 'Message Display'},
    {'name': 'Product List with Login Screen'},
    {"name" : 'Student Registration Form'}

  ];
  ProjectLookup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => ProfilePage()));
            },
            icon: Icon(Icons.arrow_back),
          style: IconButton.styleFrom(iconSize: 33),
        ),
        title: Text("Projects",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
        backgroundColor: Colors.blueAccent.shade200,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index){
        var project = projects[index];
        return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.code),),
                title: Text(project['name'], style: TextStyle(fontSize: 20),),
              trailing: ElevatedButton(onPressed: (){
                switch(project['name']){
                  case 'Hello World':
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HelloWorld()));
                    break;
                  case 'Message Display':
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MessageDisplay()));
                    break;
                  case 'Product List with Login Screen':
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginApp()));
                    break;
                  case 'Student Registration Form':
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SRP()));
                    break;
                }
              },
                  child: Icon(Icons.remove_red_eye)),
                // subtitle: ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ))
                // },
                //     child: Icon(Icons.text_snippet)),
            )
        );
      },)
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Card(semanticContainer: true, child: Text("Hola"),),
      //   ],
      // )
    );
  }
}
