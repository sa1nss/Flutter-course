import 'package:flutter/material.dart'; 
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeProvider Tests', () {
    test('Default theme is light', () async {
      SharedPreferences.setMockInitialValues({});
      final theme = ThemeProvider();

      // Ждемо завантаження теми
      await Future.delayed(const Duration(milliseconds: 50));

      expect(theme.isDark, false);
    });

    test('toggleTheme() switches between light and dark', () async {
      SharedPreferences.setMockInitialValues({});
      final theme = ThemeProvider();

      await Future.delayed(const Duration(milliseconds: 50));

      theme.toggleTheme();
      expect(theme.isDark, true);

      theme.toggleTheme();
      expect(theme.isDark, false);
    });

    test('Saved theme loads correctly from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'isDark': true});

      final theme = ThemeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(theme.isDark, true);
      expect(theme.themeMode, ThemeMode.dark);
    });
  });
}
