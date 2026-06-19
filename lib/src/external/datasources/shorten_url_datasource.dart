import 'package:dio/dio.dart';

import '../../domain/dto/entities/shortened_url_entity.dart';
import '../../domain/dto/params/shorten_url_params_entity.dart';
import '../dto/models/shortened_url_model.dart';
import '../dto/params/shorten_url_params_model.dart';
import '../provider/shorten_url_history_provider.dart';

class ShortenUrlDatasource {
  final Dio dio;
  final ShortenUrlHistoryProvider storageProvider;

  const ShortenUrlDatasource(
    this.dio,
    this.storageProvider,
  );

  Future<ShortenedUrlEntity> shortenUrl(
    ShortenUrlParamsEntity params,
  ) async {
    final response = await dio.post(
      '/alias',
      data: ShortenUrlParamsModel.fromEntity(params).toJson(),
    );

    final model = ShortenedUrlModel.fromJson(response.data);
    await storageProvider.save(model);

    return model;
  }

  Future<ShortenedUrlEntity> getShortenedUrlById(int id) async {
    final response = await dio.get('/alias/$id');

    return ShortenedUrlModel.fromJson(response.data);
  }

  Future<List<ShortenedUrlEntity>> getShortenedUrlHistory([
    GetShortenedUrlHistoryParamsEntity? params,
  ]) async {
    return storageProvider.getHistory(
      params ?? const GetShortenedUrlHistoryParamsEntity(),
    );
  }
}
