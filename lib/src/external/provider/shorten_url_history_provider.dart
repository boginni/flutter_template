import '../../domain/dto/entities/shortened_url_entity.dart';
import '../../domain/dto/params/shorten_url_params_entity.dart';

class ShortenUrlHistoryProvider {
  factory ShortenUrlHistoryProvider() => _instance;

  ShortenUrlHistoryProvider._();

  static final ShortenUrlHistoryProvider _instance =
      ShortenUrlHistoryProvider._();

  final shortenedUrlCache = <ShortenedUrlEntity>[];

  Future<List<ShortenedUrlEntity>> getHistory(
    GetShortenedUrlHistoryParamsEntity params,
  ) async {
    if (shortenedUrlCache.length < params.limit) {
      return shortenedUrlCache;
    }

    return shortenedUrlCache.sublist(0, params.limit);
  }

  Future<void> save(
    ShortenedUrlEntity entity,
  ) async {
    shortenedUrlCache.insert(0, entity);
  }

  Future<void> remove(
    ShortenedUrlEntity entity,
  ) async {
    shortenedUrlCache.remove(entity);
  }
}
