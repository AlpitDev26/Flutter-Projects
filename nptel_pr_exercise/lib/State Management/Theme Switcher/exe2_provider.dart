import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ThemeProvider();
      },
      child: const TextSwitcher(),
    ),
  );
}

class TextSwitcher extends StatelessWidget {
  const TextSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Theme Switcher App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.currentTheme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
