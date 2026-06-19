import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStore extends ChangeNotifier implements ValueListenable<AppStore> {
  AppStore();

  @override
  AppStore get value => this;

  ThemeMode? _themeMode;

  Locale? _locale;

  ThemeMode? get themeMode => _themeMode;

  Locale? get locale => _locale;

  set themeMode(ThemeMode? value) {
    _themeMode = value;
    notifyListeners();
  }

  set locale(Locale? value) {
    _locale = value;
    notifyListeners();
  }
}
