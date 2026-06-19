import 'package:flutter/foundation.dart';

class ShellStore extends ChangeNotifier implements ValueListenable<ShellState> {
  ShellStore();

  ShellState _state = const ShellLoadingState();

  ShellState get state => _state;

  set state(ShellState newState) {
    _state = newState;
    notifyListeners();
  }

  @override
  ShellState get value => _state;
}

sealed class ShellState {
  const ShellState();
}

class ShellLoadingState extends ShellState {
  const ShellLoadingState();
}

class ShellSuccessState extends ShellState {
  const ShellSuccessState();
}

class ShellErrorState extends ShellState {
  const ShellErrorState();
}
