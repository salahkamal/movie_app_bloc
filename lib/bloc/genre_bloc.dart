import 'dart:async';

import '../model/Genre.dart';
import '../repository/movie_repository.dart';

enum GenreAction {
  Fetch,
}

class GenreBloc {
  Future<List<Genre>> getGenresFromRepo() async {
    var geners = await MovieRepository().getGenre();
    return geners;
  }

  final _stateStreamController = StreamController<List<Genre>>.broadcast();
  StreamSink<List<Genre>> get _genersSink => _stateStreamController.sink;
  Stream<List<Genre>> get genersStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<GenreAction>();
  StreamSink<GenreAction> get eventSink => _eventStreamController.sink;
  Stream<GenreAction> get _eventStream => _eventStreamController.stream;

  GenreBloc() {
    _eventStream.listen((event) async {
      if (event == GenreAction.Fetch) {
        var genres = await getGenresFromRepo();
        _genersSink.add(genres);
      }
    });
  }

  streamDispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
