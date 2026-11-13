// This provider manages the list of favorite meals for the app.
//
// Purpose: Keep track of user's favorite meals and provide methods
// to toggle a meal's favorite status.
//
// File purpose (EN + MR):
// - English: Central state manager for favorite meals using Riverpod.
// - Marathi: Riverpod वापरून आवडत्या (favorite) meals चे राज्य राखण्याचा केंद्रस्थानी घटक.

// import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_recipe_app/models/meal_model.dart';

/// A StateNotifier that holds a list of favorite [MealModel]s.
///
/// English: Manages the favorites list and exposes a toggle method to add
/// or remove a meal from favorites.
/// Marathi: हा notifier favorite meals ची यादी सांभाळतो आणि एखादा meal
/// favorite मध्ये जोडा किंवा काढण्यासाठी toggle method देतो.
class FavoritesMealsNotifier extends StateNotifier<List<MealModel>> {
  /// Initialize with an empty favorites list.
  /// English: Start with an empty list because no favorites exist initially.
  /// Marathi: सुरुवातीला favorites रिकाम्या यादीने सुरू करतो कारण काहीही निवडलेले
  /// अस्तित्त्वात नाही.
  FavoritesMealsNotifier() : super([]);

  /// Toggle the favorite status of a meal.
  ///
  /// If the meal is already in the favorites list, it will be removed and the
  /// method returns `false` (meaning it is no longer a favorite). Otherwise,
  /// the meal will be added and the method returns `true`.
  ///
  /// English: Adds the meal to favorites if missing, removes it if present.
  /// Marathi: जर meal आधीच favorites मध्ये असेल तर काढतो, नसल्यास जोडतो.
  /// Returns: `true` if the meal was added; `false` if it was removed.
  bool toggleMealFavStatus(MealModel meal) {
    bool mealIsFav = state.contains(meal);
    if (mealIsFav) {
      // Remove the meal from favorites list.
      // Marathi: favorites यादीमधून meal काढता येईल.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // Add the meal to favorites list.
      // Marathi: favorites यादीमध्ये meal जोडले जाते.
      state = [...state, meal];
      return true;
    }
  }
}

/// Riverpod provider that exposes the favorites notifier and its state.
///
/// English: Use `favoriteMealsProvider` to read or watch the current list of
/// favorite meals and to call notifier methods.
/// Marathi: current favorite यादी व notifier method वापरण्यासाठी हा provider वापरा.
final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<MealModel>>((ref) {
  return FavoritesMealsNotifier();
});
