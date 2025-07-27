import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  final ThemeModeType mode;
  final Color primaryColor;

  AppTheme({required this.mode, this.primaryColor = Colors.blue});

  AppTheme copyWith({
    ThemeModeType? mode,
    Color? primaryColor,
  }) {
    return AppTheme(
      mode: mode ?? this.mode,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

enum ThemeModeType {
  light,
  dark,
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme(mode: ThemeModeType.light));

  void toggleTheme() {
    state = state.copyWith(
      mode: state.mode == ThemeModeType.light ? ThemeModeType.dark : ThemeModeType.light,
    );
  }

  void changePrimaryColor(Color color) {
    state = state.copyWith(primaryColor: color);
  }
}
