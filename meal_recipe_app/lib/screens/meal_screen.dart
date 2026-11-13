import 'package:flutter/material.dart';
import 'package:meal_recipe_app/models/meal_model.dart';
import 'package:meal_recipe_app/screens/meals_detailed_screen.dart';
import 'package:meal_recipe_app/widgets/item_trait.dart';

import '../data/meal_data.dart';

class MealScreen extends StatelessWidget {
  final String title;
  final Color color;
  final String catId;

  const MealScreen({
    super.key,
    required this.title,
    required this.color,
    required this.catId,
  });

  @override
  Widget build(BuildContext context) {
    List<MealModel> filterMeal = meals.where((meal) {
      return meal.categories.contains(catId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: Colors.amber,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filterMeal.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MealsDetailedScreen(meal: filterMeal[index]),
                  ),
                );
              },
              child: Card(
                color: Colors.amber.shade300,
                clipBehavior: Clip.hardEdge,
                elevation: 1.8,
                child: Stack(
                  children: [
                    Image.asset(
                      filterMeal[index].imageUrl,
                      height: 250,
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              filterMeal[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Icon(Icons.work, color: Colors.white,),
                            //     SizedBox(width: 3,),
                            //     Text(
                            //       filterMeal[index].complexity.name,
                            //       style: TextStyle(
                            //         fontSize: 17,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     SizedBox(width: 15,),
                            //     Icon(Icons.currency_rupee, color: Colors.white,),
                            //     SizedBox(width: 3,),
                            //     Text(
                            //       filterMeal[index].affordability.name,
                            //       style: TextStyle(
                            //         fontSize: 17,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     SizedBox(width: 15,),
                            //     Icon(Icons.hourglass_bottom, color: Colors.white,),
                            //     SizedBox(width: 3,),
                            //     Text(
                            //       filterMeal[index].duration.toString(),
                            //       style: TextStyle(
                            //         fontSize: 17,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ItemTrait(
                                  text: filterMeal[index].complexity.name,
                                  icon: Icons.work,
                                ),
                                SizedBox(width: 8),
                                ItemTrait(
                                  text: filterMeal[index].affordability.name,
                                  icon: Icons.currency_rupee,
                                ),
                                SizedBox(width: 8),
                                ItemTrait(
                                  text: filterMeal[index].duration.toString(),
                                  icon: Icons.hourglass_bottom,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
