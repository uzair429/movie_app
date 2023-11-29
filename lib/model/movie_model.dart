// movie_model.dart
class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      backdropPath: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
    );
  }
}
