// import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieappbloc/bloc/genre_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../model/Genre.dart';
import '../model/Movie.dart';
import 'FavouritsScreen.dart';
import 'GenreTileWidget.dart';
import 'movie_detail.dart';

class MovieListScreen extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListScreen> {
  bool selected = false;
  Set<Movie> _saved = Set<Movie>();
  List<Genre> genres = List<Genre>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  final movieBloc = MovieBloc();
  final genreBloc = GenreBloc();
  List<Genre> genreList;
  @override
  void initState() {
    init();

    super.initState();
  }

  Future init() async {
    genreBloc.eventSink.add(GenreAction.Fetch);
    await Future.delayed(Duration(seconds: 3));
    movieBloc.eventSink.add(MovieAction.Fetch);
  }

  @override
  void dispose() {
    movieBloc.streamsDispose();
    genreBloc.streamDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies From Api'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: Container(child: _buildMovies()));
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return FavouritesScreen(_saved);
        },
      ),
    );
  }

  Widget _buildMovies() {
    return StreamBuilder<List<Genre>>(
        stream: genreBloc.genersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            genreList = snapshot.data;
            return Container(
              child: StreamBuilder<List<Movie>>(
                  stream: movieBloc.moviesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var movieList = snapshot.data;
                      return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: movieList.length,
                          itemBuilder: (_, i) {
                            if (i.isOdd) {
                              return Divider();
                            }
                            final int index = i ~/ 2;
                            return _buildRow(movieList[index]);
                          });
                    } else
                      return Center(child: CircularProgressIndicator());
                  }),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildRow(Movie movie) {
    bool alreadySaved = _saved.contains(movie);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetail(movie))),
          leading: Hero(
            tag: "poster_" + movie.posterPath,
            child: Image.network(
                "https://image.tmdb.org/t/p/w92" + movie.posterPath),
          ),
          title: Text(
            movie.title,
            style: _biggerFont,
          ),
          subtitle: Text(
            'Release Date : ${movie.releaseDate}',
          ),
          trailing: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                  if (alreadySaved) {
                    _saved.remove(movie);
                  } else {
                    _saved.add(movie);
                  }
                });
              },
              child: AnimatedContainer(
                width: alreadySaved ? 30 : 25,
                height: alreadySaved ? 30 : 25,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 1),
                child: Icon(
                  alreadySaved ? Icons.star : Icons.star_border,
                  color: alreadySaved ? Colors.amber : null,
                  size: alreadySaved ? 30 : 25,
                ),
              )),
//          onTap: () {
//            setState(() {
//              if (alreadySaved) {
//                _saved.remove(movie);
//              } else {
//                _saved.add(movie);
//              }
//            });
//          },
        ),
        SizedBox(
          height: 60.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: movie.genreIds
                .map((genreId) => GenreTile(getGenreName(genreId, genreList)))
                .toList(),
          ),
        ),
      ],
    );
  }

  String getGenreName(int id, List<Genre> gen) {
    Genre g = gen.firstWhere((item) => item.id == id);
    return g.name;
  }
}
