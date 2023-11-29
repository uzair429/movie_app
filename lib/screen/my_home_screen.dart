import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/screen/search_screen.dart';
import '../api/movie_api.dart';
import '../constants.dart';
import '../hive_database/movies_database.dart';
import '../model/movie_model.dart';
import 'detail_screen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late Box<MovieCacheData> hiveBox;
  late MovieApiClient movieApiClient;
  late List<Movie> movies;

  @override
  void initState() {
    super.initState();
    hiveBox = Hive.box<MovieCacheData>(HiveBoxes.movies);
    movieApiClient = MovieApiClient();
    movies = [];
    fetchDataAndCache();
  }

  Future<void> fetchDataAndCache() async {
    try {
      // Load data from Hive
      final List<MovieCacheData> cachedMovies = hiveBox.values.toList();

      // Display cached data
      setState(() {
        movies = cachedMovies.map((cachedMovie) {
          return Movie(
            id: cachedMovie.id,
            title: cachedMovie.title,
            overview: cachedMovie.overview,
            posterPath: cachedMovie.posterPath,
            backdropPath: cachedMovie.backdropPath,
          );
        }).toList();
      });

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
        );
      }).toList();

      // Clear existing data in Hive box
      await hiveBox.clear();

      // Save new data to Hive box
      await hiveBox.addAll(movieCacheData);

      // Update screen with the latest data
      setState(() {
        movies = movieCacheData.map((cachedMovie) {
          return Movie(
            id: cachedMovie.id,
            title: cachedMovie.title,
            overview: cachedMovie.overview,
            posterPath: cachedMovie.posterPath,
            backdropPath: cachedMovie.backdropPath,
          );
        }).toList();
      });

    } catch (e) {
      print('Error fetching and caching data: $e');
    }
  }

  @override
  void dispose() {
    closeHiveBox(); // Close Hive box when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Watch',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),),
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return MovieSearchScreen();
                    }));
                  }, icon: Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.backgroundColor,
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return DetailScreen(movie: movie);
                        }));
                      },
                      child: Center(
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child:
                                CachedNetworkImage(
                                  imageUrl: movie.backdropPath,
                                  placeholder: (context, url) =>
                                      SizedBox(
                                        width: size.width,
                                      height: size.height * .25,
                                      child: const Center(child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) => SizedBox(
                                    width: size.width,
                                    height: size.height * .25,
                                    child:const Center(child: Icon(Icons.error))),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins'
                                      ),),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}