import '../../../domain/dto/entities/shortened_url_entity.dart';

class ShortenedUrlModel extends ShortenedUrlEntity {
  const ShortenedUrlModel({
    required super.id,
    required super.url,
    required super.originalUrl,
  });

  factory ShortenedUrlModel.fromJson(Map<String, dynamic> json) {
    final links = json['_links'] as Map<String, dynamic>? ?? {};

    return ShortenedUrlModel(
      id: json['id'] as int? ?? 0,
      originalUrl: links['self'] as String? ?? '',
      url: links['short'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': id.toString(),
      '_links': {
        'self': originalUrl,
        'short': url,
      },
    };
  }

  factory ShortenedUrlModel.fromEntity(ShortenedUrlEntity entity) {
    return ShortenedUrlModel(
      id: entity.id,
      url: entity.url,
      originalUrl: entity.originalUrl,
    );
  }

  ShortenedUrlEntity toEntity() {
    return ShortenedUrlEntity(
      id: id,
      url: url,
      originalUrl: originalUrl,
    );
  }
}
