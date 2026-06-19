import 'package:error_handler_with_result/error_handler_with_result.dart';

import '../dto/entities/shortened_url_entity.dart';
import '../dto/params/shorten_url_params_entity.dart';

abstract interface class ShortenUrlRepository {
  Future<Result<ShortenedUrlEntity>> shortenUrl(
    ShortenUrlParamsEntity params,
  );

  Future<Result<ShortenedUrlEntity>> getShortenedUrlById(int id);

  Future<Result<List<ShortenedUrlEntity>>> getRecentlyShortenedUrls([
    GetShortenedUrlHistoryParamsEntity? params,
  ]);
}
