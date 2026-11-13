import 'package:flutter/material.dart';
// import 'package:meal_recipe_app/screens/category_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_recipe_app/screens/home_screen.dart';

class MealRecipeApp extends StatelessWidget {
  const MealRecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meal Recipe App",
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
      home: HomeScreen(),
    );
  }
}
