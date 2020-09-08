import 'package:first_flutter_app/model/Movie.dart';
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movies = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
                children: [
                  Positioned(
                      child: movieCard(movies[index], context)
                  ),
                  Positioned(
                      top: 10.0,
                      child: movieImage(movies[index].images.first)
                  )
                ]
            );
          }
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(movie.title, style: titleMovieTextStyle())),
                      Text("Rating: ${movie.imdbRating} / 10", style: mainTextStyle())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released: ${movie.released}", style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle())
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieListViewDetail(movie: movie)
          )
      ),
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
        fontSize: 12,
        color: Colors.grey
    );
  }

  TextStyle titleMovieTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Colors.white
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl ?? 'https://picsum.photos/100'),
              fit: BoxFit.cover
          )
      ),
    );
  }

}

class MovieListViewDetail extends StatelessWidget {

  final Movie movie;

  const MovieListViewDetail({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie - ${movie.title}"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images.first),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images)
        ],
      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {

  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Icon(Icons.play_circle_outline, size: 100, color: Colors.white)
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {

  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images.first),
          SizedBox(width: 16),
          Expanded(
            child: MovieDetailHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {

  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(poster),
                  fit: BoxFit.fill
              )
          ),
        ),
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {

  final Movie movie;

  const MovieDetailHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.cyan
          ),
        ),
        Text(
          movie.title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32
          ),
        ),
        Text.rich(
            TextSpan(
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300
                ),
                children: <TextSpan> [
                  TextSpan(
                      text: movie.plot
                  )
                ]
            )
        )
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {

  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director(s)", value: movie.director),
          MovieField(field: "Awards",value: movie.awards),
          MovieField(field: "Duration",value: movie.runtime),
          MovieField(field: "Writer(s)",value: movie.writer)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {

  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field: ", style: TextStyle(
          color: Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),),
        Expanded(
          child: Text(value, style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300
          ),),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {

  final List<String> posters;

  const MovieDetailsExtraPosters({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("More movie posters".toUpperCase(), style: TextStyle(
              fontSize: 14,
              color: Colors.black26
          ),),
          Container(
            height: 170,
            padding: EdgeInsets.only(top: 8),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: posters.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(posters[index]),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}