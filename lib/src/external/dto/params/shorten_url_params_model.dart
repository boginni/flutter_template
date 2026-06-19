import '../../../domain/dto/params/shorten_url_params_entity.dart';

class ShortenUrlParamsModel extends ShortenUrlParamsEntity {
  const ShortenUrlParamsModel({
    required super.url,
  });

  factory ShortenUrlParamsModel.fromJson(Map<String, dynamic> json) {
    return ShortenUrlParamsModel(
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

  factory ShortenUrlParamsModel.fromEntity(ShortenUrlParamsEntity entity) {
    return ShortenUrlParamsModel(
      url: entity.url,
    );
  }

  ShortenUrlParamsEntity toEntity() {
    return ShortenUrlParamsEntity(
      url: url,
    );
  }
}
