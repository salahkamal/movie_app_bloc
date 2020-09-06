import '../api-providers/movies_api.dart';
import '../model/Genre.dart';
import '../model/Movie.dart';

class MovieRepository {
  Future<List<Movie>> getMovies() async {
    return await MoviesApi().fetchMoviesOnline();
  }

  Future<List<Genre>> getGenre() async {
    return await MoviesApi().getGenres();
  }
}
