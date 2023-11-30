// movie_api_client.dart
import 'package:dio/dio.dart';
import '../model/genre_model.dart';
import '../model/movie_model.dart';

class MovieApiClient {
  final Dio dio = Dio();
  final  apiKey = '0fa770fd29aa7a27d41ac44747546479';

  Future<List<Movie>> fetchMovies() async {

    print('api called');
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/upcoming',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['results'])
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  // Assume this function is used to fetch genre data from the API
  Future<Map<int, String>> fetchGenreData() async {
    final response = await dio.get('https://api.themoviedb.org/3/genre/movie/list',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      var genres = List<Map<String, dynamic>>.from(response.data['genres'])
          .map((json) => Genre.fromJson(json))
          .toList();
      Map<int, String> genreMap = {};
      for (var genre in genres) {
        genreMap[genre.id] = genre.name;
      }
      return genreMap;
    } else {
      throw Exception('Failed to load genre data');
    }
  }

  Future fetchVideo(String movieId) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId/videos',
        queryParameters: {'api_key': apiKey},
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final trailerKey = findOfficialTrailerKey(jsonResponse);
        return trailerKey;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String findOfficialTrailerKey(Map<String, dynamic> jsonResponse) {
    final List<dynamic> results = jsonResponse['results'];
    for (final result in results) {
      if (result['official'] == true) {
        return result['key'];
      }
    }
    return '';
  }

  Future<List<Movie>?> searchMovie(query) async {
    const baseUrl = 'https://api.themoviedb.org/3/search/movie';
    const language = 'en-US';
    const includeAdult = 'false';

    final response = await dio.get(
      baseUrl,
      queryParameters: {
        'api_key': apiKey,
        'query': query,
        'include_adult': includeAdult,
        'language': language,
      },
    );

    if (response.statusCode == 200) {
      final results = response.data['results'] as List<dynamic>;
        return results.map((result) => Movie.fromJson(result)).toList();
    }
    return null;
  }
}
