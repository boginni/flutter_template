import 'dart:async';

import '../../../domain/dto/params/shorten_url_params_entity.dart';
import '../../../domain/repositories/device_runtime_repository.dart';
import '../../../domain/repositories/shorten_url_repository.dart';
import 'home_store.dart';
import 'shorten_history_store.dart';

class HomeController {
  final HomeStore store;
  final ShortenHistoryStore shortenHistoryStore;
  final ShortenUrlRepository repository;
  final DeviceRuntimeRepository runtimeRepository;

  const HomeController(
    this.repository,
    this.runtimeRepository, {
    required this.store,
    required this.shortenHistoryStore,
  });

  Future<void> init() async {
    if (shortenHistoryStore.state is ShortenHistoryStoreInitialState) {
      await Future.delayed(const .new(milliseconds: 250));
      await loadHistory();
    }
  }

  Future<void> loadHistory() async {
    final result = await repository.getRecentlyShortenedUrls();

    if (result.isFailure) {
      shortenHistoryStore.state = ShortenHistoryStoreState.failure(
        result.failure,
      );

      result.failure.throwError();
    }

    final entities = result.success;

    if (entities.isEmpty) {
      shortenHistoryStore.state = ShortenHistoryStoreState.empty();

      return;
    }

    shortenHistoryStore.state = ShortenHistoryStoreState.success(
      result.success,
    );

    return;
  }

  Future<void> shortenUrl(String url) async {
    store.state = HomeStoreState.loading();

    final result = await repository.shortenUrl(
      ShortenUrlParamsEntity(
        url: url,
      ),
    );

    if (result.isFailure) {
      store.state = HomeStoreState.failure(result.failure);
      result.failure.throwError();
    }

    unawaited(loadHistory());
    store.state = HomeStoreState.success();
  }
}
