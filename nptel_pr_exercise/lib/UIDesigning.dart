import 'package:flutter/material.dart';

void main() {
  runApp(UIScreen());
}

class UIScreen extends StatelessWidget {
  const UIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UIScreenPage(), debugShowCheckedModeBanner: false);
  }
}

class UIScreenPage extends StatelessWidget {
  const UIScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F3F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Alpit Gadhave",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              iconSize: 18,
                              color: Colors.black,
                              onPressed: () {},
                              icon: Icon(Icons.notifications_none_outlined),
                            ),
                          ),
                          SizedBox(width: 15),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              iconSize: 18,
                              color: Colors.black,
                              onPressed: () {},
                              icon: Icon(Icons.dark_mode),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  quickAction(icon: Icons.payment, label: "Pay", color: Colors.blue[200]),
                  quickAction(icon: Icons.send , label: "Send", color: Colors.green[200]),
                  quickAction(icon: Icons.document_scanner_outlined, label: "Scan", color: Colors.amber[200]),
                  quickAction(icon: Icons.more_horiz_outlined, label: "More", color: Colors.purple[200]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  quickAction({required IconData icon, required String label, required color}) { return
    Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(12),
          child: Icon(icon, color: Colors.black, size: 28),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.black)),
      ],
    );
  }
}
