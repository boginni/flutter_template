class ShortenUrlParamsEntity {
  final String url;

  const ShortenUrlParamsEntity({required this.url});
}

class GetShortenedUrlHistoryParamsEntity {
  final int limit;

  const GetShortenedUrlHistoryParamsEntity({
    this.limit = 20,
  });
}
