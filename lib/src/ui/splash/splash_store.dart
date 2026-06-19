import 'package:flutter/cupertino.dart';

class SplashStore extends ChangeNotifier {
  SplashStoreState _state = SplashStoreState.loading();

  SplashStoreState get state => _state;

  set state(SplashStoreState value) {
    _state = value;
    notifyListeners();
  }
}

sealed class SplashStoreState {
  const SplashStoreState();

  factory SplashStoreState.loading() = SplashStoreLoadingState;
}

class SplashStoreLoadingState extends SplashStoreState {}
