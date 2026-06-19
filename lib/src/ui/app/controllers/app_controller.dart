import 'package:flutter/material.dart';

import '../app_routes.dart';
import 'app_store.dart';

class AppController {
  final AppStore store;
  final AppRoutes appRoutes;

  const AppController(
    this.store, {
    required this.appRoutes,
  });

  Future<void> init() async {}

  Future<void> setThemeMode(ThemeMode? themeMode) async {
    if (themeMode == null) {
      return;
    }

    store.themeMode = themeMode;
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      return;
    }

    store.locale = locale;
  }
}
