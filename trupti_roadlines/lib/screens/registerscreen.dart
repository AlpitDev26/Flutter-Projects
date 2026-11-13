import 'package:flutter/material.dart';
import 'package:trupti_roadlines/screens/loginscreen.dart';

class Registerscreen extends StatelessWidget {

  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  final TextEditingController _confirmPasswordInput = TextEditingController();
  Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Registration",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 25),
                Icon(Icons.app_registration_sharp, size: 120, color: Colors.teal),
                SizedBox(height: 25),
                TextFormField(
                  controller: _emailInput,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordInput,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password should no be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: _confirmPasswordInput,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password should not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if(_passwordInput == _confirmPasswordInput) {
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Register", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
