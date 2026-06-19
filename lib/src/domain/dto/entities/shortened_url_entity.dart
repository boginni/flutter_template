class ShortenedUrlEntity {
  final int id;
  final String url;
  final String originalUrl;

  const ShortenedUrlEntity({
    required this.id,
    required this.url,
    required this.originalUrl,
  });
}
