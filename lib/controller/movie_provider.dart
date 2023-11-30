import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/model/movie_model.dart';
import '../api/movie_api.dart';
import '../hive_database/movies_database.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  late Box<MovieCacheData> hiveBox;
  late MovieApiClient movieApiClient;
  Movie? _selectedMovie;
  Movie? get selectedMovie => _selectedMovie;


  void selectMovie(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }


  Future<void> fetchDataAndCache() async {
    try {
      hiveBox = Hive.box<MovieCacheData>(HiveBoxes.movies);
      movieApiClient = MovieApiClient();

      // Load data from Hive
      final List<MovieCacheData> cachedMovies = hiveBox.values.toList();

      // Display cached data
        _movies = cachedMovies.map((cachedMovie) {
          return Movie(
              id: cachedMovie.id,
              title: cachedMovie.title,
              overview: cachedMovie.overview,
              posterPath: cachedMovie.posterPath,
              backdropPath: cachedMovie.backdropPath,
              genres: cachedMovie.genres ?? [],
              releaseDate: cachedMovie.releaseDate);
        }).toList();

      // Call API to get updated data
      final apiMovies = await movieApiClient.fetchMovies();

      // Process API response and update Hive and screen
      final movieCacheData = apiMovies.map((movie) {
        return MovieCacheData(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath,
            genres: movie.genres ?? [],
            releaseDate: movie.releaseDate);
      }).toList();

      // Clear existing data in Hive box
      await hiveBox.clear();

      // Save new data to Hive box
      await hiveBox.addAll(movieCacheData);

      // Update screen with the latest data
        _movies = movieCacheData.map((cachedMovie) {
          return Movie(
              id: cachedMovie.id,
              title: cachedMovie.title,
              overview: cachedMovie.overview,
              posterPath: cachedMovie.posterPath,
              backdropPath: cachedMovie.backdropPath,
              genres: cachedMovie.genres ?? [],
              releaseDate: cachedMovie.releaseDate);
        }).toList();
        notifyListeners();
    } catch (e) {
      print('Error fetching and caching data: $e');
    }
  }
}