import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light(); // Default theme

  ThemeData get currentTheme => _currentTheme;

  void setThemeColor(Color color) {
    _currentTheme = ThemeData.light().copyWith(
      primaryColor: color,
      accentColor: color,
    );
    notifyListeners();
  }
}
