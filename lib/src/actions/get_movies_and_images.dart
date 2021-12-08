import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/index.dart';

part 'get_movies_and_images.freezed.dart';

@freezed
class GetMovies with _$GetMovies {
  const factory GetMovies(void Function(dynamic action) result) = GetMoviesStart;

  const factory GetMovies.successful(List<Movie> movies) = GetMoviesSuccessful;

  const factory GetMovies.error(Object error, StackTrace stackTrace) = GetMoviesError;
}
