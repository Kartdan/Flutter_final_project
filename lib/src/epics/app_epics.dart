import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import '../actions/get_movies_and_images.dart';
import '../data/movies_images_api.dart';
import '../models/index.dart';

class AppEpics {
  AppEpics(this.api);
  final MIApi api;

  Epic<AppState> get epics {
    return combineEpics([
      TypedEpic<AppState, GetMoviesStart>(getMovies),
    ]);
  }

  Stream<dynamic> getMovies(Stream<GetMoviesStart> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap<void>((GetMoviesStart action) => Stream<void>.value(null)
            .asyncMap((_) => api.getMovies(store.state.page))
            .map<Object>((List<Movie> movies) => GetMovies.successful(movies))
            .onErrorReturnWith((error, stackTrace) => GetMovies.error(error, stackTrace))
            .doOnData(action.result));
  }
}
