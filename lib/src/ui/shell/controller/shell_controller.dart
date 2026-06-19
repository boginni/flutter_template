import 'package:flutter/material.dart';

import '../../app/controllers/app_controller.dart';
import '../../home/controllers/home_controller.dart';
import 'shell_store.dart';

class ShellController {
  final ShellStore store;
  final AppController appController;
  final HomeController homeController;

  const ShellController({
    required this.store,
    required this.appController,
    required this.homeController,
  });

  Future<void> setThemeMode(ThemeMode? themeMode) async {
    await appController.setThemeMode(themeMode);
  }

  Future<void> setLocale(Locale locale) async {
    await appController.setLocale(locale);

    await Future.wait([
      homeController.init(),
    ]);
  }
}
