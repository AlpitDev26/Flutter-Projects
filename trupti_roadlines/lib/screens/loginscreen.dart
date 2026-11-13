import 'package:flutter/material.dart';
import 'package:trupti_roadlines/screens/homescreen.dart';
import 'package:trupti_roadlines/screens/registerscreen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 25),
                Icon(Icons.lock, size: 120, color: Colors.teal),
                SizedBox(height: 25),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password should no be empty";
                    }
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      String validEmail = "h";
                      String validPassword = "5";

                      // Check Credentials
                      if (emailController.text == validEmail &&
                          passwordController.text == validPassword) {
                        // Navigate to the HomeScreen if Credentials match or valid
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                Homescreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid Email and Password")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Login", style: TextStyle(fontSize: 20)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Registerscreen()),
                    );
                  },
                  child: Text("Register", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

