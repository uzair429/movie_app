// movie_model.dart
class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  List<int>? genres;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    this.genres,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json,) {

    List<int> genreIds = List<int>.from(json['genre_ids']);
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      backdropPath: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      // genres:  List<String>.from(json['genres'].map((genreId) => genreMap[genreId])),
      genres: genreIds,
      releaseDate: json['release_date'],
    );
  }
}