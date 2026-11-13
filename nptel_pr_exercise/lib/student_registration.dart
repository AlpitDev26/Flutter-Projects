import 'package:flutter/material.dart';

void main(){
  runApp(SRA());
}

// ignore_for_file: file_names, unused_field

// SRA = Student Registration App
class SRA extends StatelessWidget {
  const SRA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SRP());
  }
}

class SRP extends StatefulWidget {
  const SRP({super.key});

  @override
  State<SRP> createState() => _SRPState();
}

class _SRPState extends State<SRP> {
  final _formkey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String? selectedCourses;
  String gender = "Select Your Gender";
  bool agreeToTerms = false;

  final List<String> courses = ['Diploma', 'Engineering', 'BCA', 'BCS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Registration"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full name input
              TextFormField(
                decoration: InputDecoration(label: Text("Full name")),
                onChanged: (value) => name = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),

              TextFormField(
                decoration: InputDecoration(label: Text("Email")),
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.contains("@")
                    ? null
                    : 'Enter a valid email',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) => value != null && value.length >= 6
                    ? null
                    : 'Password contains minimum 6 characters',
              ),
              SizedBox(height: 18),
              Text("Select Courses"),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(),
                // padding: EdgeInsets.all(20),
                hint: const Text("Select Courses"),
                initialValue: selectedCourses,
                onChanged: (value) {
                  setState(() {
                    selectedCourses = value!;
                  });
                },
                items: courses
                    .map(
                      (course) =>
                          DropdownMenuItem(value: course, child: Text(course)),
                    )
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select course';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text("Gender"),
              RadioListTile(
                title: Text("Male"),
                value: "Male",
                // ignore: deprecated_member_use
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text("Female"),
                value: "Female",
                // ignore: deprecated_member_use
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: agreeToTerms,
                title: Text('I agree to the Terms and Conditons'),
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      if (!agreeToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please agree to terms')),
                        );
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(name: name, email: email, password: password, selectedCourses: selectedCourses, gender: gender, agreeToTerms: agreeToTerms)));
                      }
                    }
                  },
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String? selectedCourses;
  final String gender;
  final bool agreeToTerms;


  DetailScreen({required this.name,super.key, required this.email, required this.password, required this.selectedCourses, required this.gender, required this.agreeToTerms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SRP()));
        }, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Text("Successfully Registered.....\n"
        'Name:- $name\n'
        'Email :- $email\n'
        'Password :- $password\n'
        'Selected Course :- $selectedCourses'
        'Gender :- $gender'),
      ),
    );
  }
}