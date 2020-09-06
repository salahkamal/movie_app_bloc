import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Movie.dart';

class MovieDetail extends StatelessWidget {
  Movie movie;
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: true,
      ),
      body: _bulidBody(),
    );
  }

  Widget _bulidBody() {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "poster_" + movie.posterPath,
              child: Image.network(
                  "https://image.tmdb.org/t/p/w500" + movie.posterPath),
            ),
//          SizedBox(
//            height: 8,
//          ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Release Date: " + movie.releaseDate,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Description:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    movie.overview,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        letterSpacing: 1,
                        wordSpacing: 2),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
