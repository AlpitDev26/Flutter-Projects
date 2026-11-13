import 'package:flutter/material.dart';
import 'package:nptel_pr_exercise/product_list_login.dart';
import 'package:nptel_pr_exercise/student_registration.dart';

void main(){
  runApp(MyBottomNavApp());
}

class MyBottomNavApp extends StatelessWidget {
  const MyBottomNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: SRP(),),
    Center(child: ProductListApp(),),
  ];

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation Bar"),
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.black,
        onTap: onItemTapped,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.app_registration_rounded), label: "Registration"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Product List~"),
        ],
      ),
    );
  }
}