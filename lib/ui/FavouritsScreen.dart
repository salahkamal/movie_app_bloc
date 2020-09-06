import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Movie.dart';

class FavouritesScreen extends StatelessWidget {
  Set<Movie> _saved;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  FavouritesScreen(this._saved);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = _saved.map(
      (Movie movie) {
        return ListTile(
          leading: Image.network(
              "https://image.tmdb.org/t/p/w92" + movie.posterPath),
          title: Text(
            movie.title,
            style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Movies'),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
