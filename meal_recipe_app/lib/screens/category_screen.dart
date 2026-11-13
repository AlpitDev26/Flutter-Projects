import 'package:flutter/material.dart';
import 'package:meal_recipe_app/data/category_data.dart';
import 'package:meal_recipe_app/screens/meal_screen.dart';

class MealAppCategoryScreen extends StatelessWidget {
  const MealAppCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // pratyek row madhe kiti item astil te {2}
          crossAxisSpacing: 20, // Column chya madhla gap {horizontal}
          mainAxisSpacing: 20, // Row chya madhla gap  {vertical}
        ),
        children: List.generate(categories.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealScreen(
                    title: categories[index].title,
                    color: categories[index].color,
                    catId: categories[index].id,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(categories[index].image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(16),
                // gradient: LinearGradient(colors: [
                //   categories[index].color.withOpacity(0.55),
                //   categories[index].color.withOpacity(0.9),
                // ],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
              ),
              child: Center(
                child: Text(
                  categories[index].title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
