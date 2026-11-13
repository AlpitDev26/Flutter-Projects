import 'package:flutter/material.dart';
import 'package:meal_recipe_app/screens/category_screen.dart';
import 'package:meal_recipe_app/screens/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [MealAppCategoryScreen(), FavoriteScreen()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "Category",
            icon: Icon(Icons.category_rounded),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          ),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.amberAccent,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
