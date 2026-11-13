import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:techquiz_tic/screens/homescreen.dart';
import 'package:techquiz_tic/screens/splashscreen.dart';

class TechQuizApp extends StatelessWidget {
  const TechQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TechQuizz For TIC",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 180, 11, 57)),
          textTheme: GoogleFonts.latoTextTheme(),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarThemeData(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white
          )
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
