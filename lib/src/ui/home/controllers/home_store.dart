import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeStore extends ChangeNotifier
    implements ValueListenable<HomeStoreState> {
  final formKey = GlobalKey<FormState>();

  final urlController = TextEditingController();

  HomeStoreState _state = HomeStoreState.success();

  HomeStoreState get state => _state;

  set state(HomeStoreState value) {
    _state = value;
    notifyListeners();
  }

  @override
  HomeStoreState get value => _state;
}

sealed class HomeStoreState {
  const HomeStoreState();

  factory HomeStoreState.loading() = HomeStoreLoadingState;

  factory HomeStoreState.failure(Failure failure) = HomeStoreFailureState;

  factory HomeStoreState.success() = HomeStoreSuccessState;
}

class HomeStoreLoadingState extends HomeStoreState {
  const HomeStoreLoadingState();
}

class HomeStoreFailureState extends HomeStoreState {
  const HomeStoreFailureState(this.failure);

  final Failure failure;
}

class HomeStoreSuccessState extends HomeStoreState {
  const HomeStoreSuccessState();
}
