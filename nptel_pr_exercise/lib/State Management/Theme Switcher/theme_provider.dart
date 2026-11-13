import 'package:flutter/material.dart';

// A ChangeNotifier class that manages the theme state (Light/Dark).
// Used with provider to update the UI Components when the theme change.
class ThemeProvider extends ChangeNotifier {
  // Private variable that tracks if the dark mode is enabled
  bool _isDarkMode = false;

  // Getter to exposed the current theme mode (true for dark / false for light)
  bool get isDarkMode {
    return _isDarkMode;
  }

  // Getter is exposed to current theme mode (Light or Dark)
  // This can be used in Material's "ThemeMode" property
  ThemeMode get currentTheme{
    if(_isDarkMode){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }

  /// Function to toggle the theme between the light and dark
/// It updates "isDarkMode" and notifies listeners (UI will rebuild)

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;   // flip the boolean value
    notifyListeners();    // xNotify all the widgets listening to this provider
}
}