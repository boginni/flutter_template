import 'package:error_handler_with_result/error_handler_with_result.dart';

import '../../domain/dto/entities/shortened_url_entity.dart';
import '../../domain/dto/params/shorten_url_params_entity.dart';
import '../../domain/repositories/shorten_url_repository.dart';
import '../datasources/shorten_url_datasource.dart';

class ShortenUrlRepositoryImpl implements ShortenUrlRepository {
  final ShortenUrlDatasource datasource;

  const ShortenUrlRepositoryImpl(this.datasource);

  @override
  Future<Result<List<ShortenedUrlEntity>>> getRecentlyShortenedUrls([
    GetShortenedUrlHistoryParamsEntity? params,
  ]) async {
    try {
      return Result.success(
        await datasource.getShortenedUrlHistory(params),
      );
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result<ShortenedUrlEntity>> getShortenedUrlById(int id) async {
    try {
      return Result.success(
        await datasource.getShortenedUrlById(id),
      );
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result<ShortenedUrlEntity>> shortenUrl(
    ShortenUrlParamsEntity params,
  ) async {
    try {
      return Result.success(
        await datasource.shortenUrl(params),
      );
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }
}
