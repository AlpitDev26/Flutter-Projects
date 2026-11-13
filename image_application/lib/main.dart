import 'package:flutter/material.dart';

// Applications Starts from main function
void main() {
  runApp(ImageDisplayApp());
}

class ImageDisplayApp extends StatelessWidget {
  const ImageDisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ImageDisplayPage(),
    );
  }
}

class ImageDisplayPage extends StatelessWidget {
  final String networkImageUrl = 'https://c4.wallpaperflare.com/wallpaper/451/804/949/pokemon-bulbasaur-pokemon-marill-pokemon-pikachu-wallpaper-preview.jpg';     // explicitly declaring the image location
  const ImageDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.tealAccent[400],
      appBar: AppBar(title: Text("Image Display"), centerTitle: true),
      body: SingleChildScrollView(     // if widget is getting more space or numerous widget on page then it works like scrollable item
        child: Padding(
          padding: EdgeInsets.all(16),   // giving padding from all sides 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Image from Local Assets",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              // The Image.asset widget is wrapped in a Container to apply a border radius and box shadow.
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // Adds a border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(
                        0,
                        3,
                      ), // Controls the shadow position
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/togepi.png',
                    // The path to your local asset
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover, // Ensures the image covers the area
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Image from Network (Internet)",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
               // The Image.network widget is wrapped in a Container to apply a border radius and box shadow.
              ClipOval(
                // borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://c4.wallpaperflare.com/wallpaper/341/779/779/pokemon-pokemon-the-movie-the-power-of-us-chansey-pokemon-eevee-pokemon-wallpaper-thumb.jpg',
                  // The path to your local asset
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover, // Ensures the image covers the area
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // Adds a border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withValues(alpha: 0.5),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: const Offset(2,3) // Controls the shadow position
                    ),
                  ],
                ),
                child:
                ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://c4.wallpaperflare.com/wallpaper/341/779/779/pokemon-pokemon-the-movie-the-power-of-us-chansey-pokemon-eevee-pokemon-wallpaper-thumb.jpg',
                    // The path to your local asset
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover, // Ensures the image covers the area
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              // The Image.network widget with loading and error handling.
              // This widget directly handles the remote image URL.
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(networkImageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
