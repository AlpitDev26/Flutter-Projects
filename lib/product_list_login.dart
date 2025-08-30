import 'package:alpit_portfolio/project_lookup.dart';
import 'package:flutter/material.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Screen",
      home: LoginScreen(), // Starting Screen
      debugShowCheckedModeBanner: false, // hides the debug banner
    );
  }
}

// Login Screen Widget
class LoginScreen extends StatelessWidget {
  // Key is validate the form
  final _formKey = GlobalKey<FormState>();
  // Controllers to retrieve text from the input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // provides app structure - app bar, body, etc
      appBar: AppBar(
        title: Text("Login Page"), // App Bar with title
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProjectLookup()));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        // Makes the screen scrollable (important on small screen)
        padding: EdgeInsets.all(20),
        child: Form(
          // wraps the input fields to enable validation
          key: _formKey, // Assigning the form key
          child: Column(
            children: [
              SizedBox(height: 50),
              Icon(Icons.lock, size: 100, color: Colors.teal),
              SizedBox(height: 25),

              // Email Input Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(), // Outline Box
                ),
                validator: (value) {
                  // shows error when its empty
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),

              // Password Input Fields
              TextFormField(
                controller: passwordController,
                obscureText: true, // hides input
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password should not be empty";
                  }
                  return null;
                },
              ),

              SizedBox(height: 35),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Validate form fields
                  if (_formKey.currentState!.validate()) {
                    // Hardcoded Valid Credentials
                    const String validEmail = "alpitprogadhave6596@gmail.com";
                    const String validPassword = "Alpit1234";

                    // Check Credentials
                    if (emailController.text == validEmail &&
                        passwordController.text == validPassword) {
                      // Navigate to the HomeScreen if Credentials match or valid
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                              ProductListApp(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid Email and Password")),
                      );
                    }
                  }
                },
                child: Text("Login"),
              ),

              // Forgot Password Button
              TextButton(onPressed: () {}, child: Text("Forgot Password")),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String email; // To display logged in email on the screen

  const HomeScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          // Logout Button
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome, $email",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Product List

class ProductListApp extends StatelessWidget {
  const ProductListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Product List",
      home: ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatelessWidget {

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Wireless Headphones',
      'price': 2499,
      'image': 'assets/images/wirelesshdp.png'
    },
    {
      'name': 'Samrt Watch',
      'price': 1499,
      'image': 'assets/images/watch.png'
    },
    {
      'name': 'Bluetooth Speaker',
      'price': 3499,
      'image': 'assets/images/blespeaker.png'
    },
    {
      'name': 'USB Charge Cable',
      'price': 499,
      'image': 'assets/images/usb.png'
    }
  ];
  ProductListPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          // Logout Button
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          var product = products[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(product['image']),
              ),
              title: Text(product['name']),
              subtitle: Text("₹${product['price']}"),
              trailing: ElevatedButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Cart🤘")));
              }, child: Text("Add Cart")),
            ),
          );
        },
      ),
    );
  }
}
