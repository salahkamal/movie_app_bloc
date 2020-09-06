import 'dart:async';
import '../model/Movie.dart';
import '../repository/movie_repository.dart';

enum MovieAction {
  Fetch,
}

class MovieBloc {
  Future<List<Movie>> getMoviesFromRepo() async {
    var movies = await MovieRepository().getMovies();
    return movies;
  }

  final _stateStreamController = StreamController<List<Movie>>.broadcast();
  StreamSink<List<Movie>> get _moviesSink => _stateStreamController.sink;
  Stream<List<Movie>> get moviesStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MovieAction>();
  StreamSink<MovieAction> get eventSink => _eventStreamController.sink;
  Stream<MovieAction> get _eventStream => _eventStreamController.stream;

  MovieBloc() {
    _eventStream.listen((event) async {
      if (event == MovieAction.Fetch) {
        var movies = await getMoviesFromRepo();
        _moviesSink.add(movies);
      }
    });
  }

  streamsDispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
