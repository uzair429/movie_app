import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/custom_widgets/custom_shadow_widget.dart';
import 'package:movies_app/screen/search_screen.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controller/movie_provider.dart';
import '../hive_database/movies_database.dart';
import '../model/movie_model.dart';
import 'detail_screen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late List<Movie> movies;

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movies = [];
    movieProvider.fetchDataAndCache();
  }

  @override
  void dispose() {
    closeHiveBox();
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
                  const Text(
                    'Watch',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return MovieSearchScreen();
                        }));
                      },
                      icon: Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: Consumer<MovieProvider>(
                  builder: (context, movieProvider, child) {
                final movies = movieProvider.movies;

                return Container(
                  color: AppColors.backgroundColor,
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return GestureDetector(
                        onTap: () {
                          movieProvider.selectMovie(movie);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DetailScreen();
                          }));
                        },
                        child: Center(
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: movie.backdropPath,
                                    placeholder: (context, url) => SizedBox(
                                        width: size.width,
                                        height: size.height * .25,
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            width: size.width,
                                            height: size.height * .25,
                                            child: const Center(
                                                child: Icon(Icons.error))),
                                  ),
                                ),
                                CustomShadowWidget(
                                  isDetail: false,
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
                                            fontFamily: 'Poppins'),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
