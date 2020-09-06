import '../http-client/network_client.dart';
import '../model/Genre.dart';
import '../model/Movie.dart';

class MoviesApi {
  Future<List<Movie>> fetchMoviesOnline() async {
    var jsonResponse = await HttpClient().fetchData(
        'https://api.themoviedb.org/3/discover/movie?page=4&api_key=380d8c64ab31c6718e3cdd8f8914347b');
    var data = jsonResponse["results"] as List;
    return List<Movie>.from(data.map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Genre>> getGenres() async {
    var jsonResponse = await HttpClient().fetchData(
        'https://api.themoviedb.org/3/genre/movie/list?id=53&api_key=380d8c64ab31c6718e3cdd8f8914347b');
    var data = jsonResponse["genres"] as List;
    return List<Genre>.from(data.map((genre) => Genre.fromJson(genre)));
  }
}
