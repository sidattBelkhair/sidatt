import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  
  bool get isDarkMode => _isDarkMode;
  
  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0a0a0a),
    primaryColor: const Color(0xFF00ff41),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00ff41),
      secondary: Color(0xFF008f11),
      surface: Color(0xFF1a1a1a),
      background: Color(0xFF0a0a0a),
    ),
  );

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFf5f5f5),
    primaryColor: const Color(0xFF1a5f2a),
  );
}