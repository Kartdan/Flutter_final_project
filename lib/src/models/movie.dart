part of models;

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String movie,
    required String image,
  }) = Movie$;

  factory Movie.fromJson(Map<dynamic, dynamic> json) => _$MovieFromJson(Map<String, dynamic>.from(json));
}
