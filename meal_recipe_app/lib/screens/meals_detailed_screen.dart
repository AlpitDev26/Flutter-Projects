import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_recipe_app/models/meal_model.dart';
import 'package:meal_recipe_app/providers/favorite_provider.dart';

class MealsDetailedScreen extends ConsumerWidget {
  // final String title;
  final MealModel meal;

  const MealsDetailedScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MealModel> favouriteMeals = ref.watch(favoriteMealsProvider);

    final isFav = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          meal.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              /// Toggle meal favorite status / प्रिय भोजन स्थिति टॉगल करा
              /// When user taps the button, access the notifier from favoriteMealsProvider
              /// and call toggleMealFavStatus to switch between favorite and non-favorite states
              bool wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavStatus(meal);

              /// Show the Message
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? "Meal is Added to Favorites...."
                        : "Meal is Removed from Favorites....",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  elevation: 2,
                  backgroundColor: wasAdded ? Colors.green : Colors.red,
                ),
              );
            },

            /// Display a filled heart icon (♥) if meal is favorite,
            /// otherwise show an empty heart outline (♡) - similar to how we mark important
            /// things as (beloved/favorite) in our daily life
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),

            /// Color the heart red when favorited,
            /// use white when not favorited for visual clarity against the background
            color: isFav ? Colors.red : Colors.white,
          ),
        ],
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  meal.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 250,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ingredients",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 4),
                ...meal.ingredients.map((item) {
                  return Text(
                    item,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.amber, fontSize: 18),
                  );
                }),
                const SizedBox(height: 15),
                Text(
                  "Steps",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 4),
                ...meal.steps.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
