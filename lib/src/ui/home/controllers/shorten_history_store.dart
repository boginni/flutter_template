import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/dto/entities/shortened_url_entity.dart';

class ShortenHistoryStore extends ChangeNotifier
    implements ValueListenable<ShortenHistoryStoreState> {
  ShortenHistoryStoreState _state = ShortenHistoryStoreState.initial();

  ShortenHistoryStoreState get state => _state;

  set state(ShortenHistoryStoreState value) {
    _state = value;
    notifyListeners();
  }

  @override
  ShortenHistoryStoreState get value => _state;
}

sealed class ShortenHistoryStoreState {
  const ShortenHistoryStoreState();

  factory ShortenHistoryStoreState.initial() = ShortenHistoryStoreInitialState;

  factory ShortenHistoryStoreState.loading() = ShortenHistoryStoreLoadingState;

  factory ShortenHistoryStoreState.failure(Failure failure) =
      ShortenHistoryStoreFailureState;

  factory ShortenHistoryStoreState.empty() = ShortenHistoryStoreEmptyState;

  factory ShortenHistoryStoreState.success(List<ShortenedUrlEntity> entities) =
      ShortenHistoryStoreSuccessState;
}

class ShortenHistoryStoreInitialState extends ShortenHistoryStoreState {
  const ShortenHistoryStoreInitialState();
}

class ShortenHistoryStoreLoadingState extends ShortenHistoryStoreState {
  const ShortenHistoryStoreLoadingState();
}

class ShortenHistoryStoreFailureState extends ShortenHistoryStoreState {
  const ShortenHistoryStoreFailureState(this.failure);

  final Failure failure;
}

class ShortenHistoryStoreSuccessState extends ShortenHistoryStoreState {
  const ShortenHistoryStoreSuccessState(this.entities);

  final List<ShortenedUrlEntity> entities;
}

class ShortenHistoryStoreEmptyState extends ShortenHistoryStoreState {
  const ShortenHistoryStoreEmptyState();
}
