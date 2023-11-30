import 'package:flutter/material.dart';
import 'package:movies_app/api/movie_api.dart';
import 'package:movies_app/screen/detail_screen.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controller/movie_provider.dart';
import '../model/movie_model.dart';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor, // Set the desired background color
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _performSearch();
                  },
                  decoration: InputDecoration(
                    hintText: 'serach',
                    border:  InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: (){
                        _searchController.clear();
                      },
                        icon: Icon(Icons.close_rounded)),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _performSearch();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              color: AppColors.backgroundColor,
              child: const Row(
                children: [
                  Text('Top Results'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.backgroundColor,
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = _searchResults[index];
                    return GestureDetector(
                      onTap: (){
                        final  provider = Provider.of<MovieProvider>(context,listen:false);
                        provider.selectMovie(movie);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DetailScreen();
                      }));
                      },
                      child: Card(
                        child: Row(
                          children: [
                          SizedBox(
                              width: 150,
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child:
                                  Image.network(
                                    movie.backdropPath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.image,
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ),
                            Expanded(
                              child: Text(
                                movie.title,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.more_horiz,color: AppColors.borderColor,),
                            )
                          ],
                        )
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

  Future<void> _performSearch() async {
    final query = _searchController.text;
    if (query.isEmpty) {
      return;
    }
    try {
      List<Movie>? result = await MovieApiClient().searchMovie(query);
      if (result != null) {
        setState(() {
          _searchResults = result;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


