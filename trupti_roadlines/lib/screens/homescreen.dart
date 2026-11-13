import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  List<String> items = ["Home", "Invoices", "Clients"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trupti Roadlines"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 28, color: Colors.black87),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){}, child: Text("Create Invoice", style: TextStyle(fontSize: 26),), style: ElevatedButton.styleFrom(maximumSize: Size(250, 90), backgroundColor: Colors.teal.shade100),),
            SizedBox(height: 16,),
            OutlinedButton(onPressed: (){}, style: OutlinedButton.styleFrom(maximumSize: Size(250, 90), backgroundColor: Colors.teal.shade100) ,child: Text("Add Client", style: TextStyle(fontSize: 26)))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: items),
    );
  }
}
