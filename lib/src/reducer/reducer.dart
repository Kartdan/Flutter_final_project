import 'package:redux/redux.dart';
import '../actions/get_movies_and_images.dart';
import '../models/index.dart';

// state + action => state
Reducer<AppState> reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesStart>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
]);

AppState _getMovies(AppState state, GetMoviesStart action) {
  return state.copyWith(isLoading: true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  final List<Movie> movies = <Movie>[];
  movies.addAll(state.movies);
  movies.addAll(action.movies);

  return state.copyWith(
    movies: movies,
    page: state.page + 1,
    isLoading: false,
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.copyWith(isLoading: false);
}
