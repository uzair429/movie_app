import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/movie_api.dart';
import '../../constants.dart';
import '../../controller/movie_provider.dart';

class GenreWidget extends StatelessWidget {
  const GenreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: FutureBuilder<Map<int, String>>(
        future: MovieApiClient().fetchGenreData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 50,
              child: genreLoading(),
            );
          } else if (snapshot.hasError) {
            return SizedBox(height: 50, child: genreLoading());
          } else {
            var genreMap = snapshot.data;
            List<int> genreIds = provider.selectedMovie!.genres!;
            List<String> genreNames = [];
            List<Color> chipColors = [
              AppColors.vip,
              AppColors.primaryColor,
              AppColors.notAvailable,
              AppColors.regularSeat,
              AppColors.selectedSeat
              // Add more colors as needed
            ];
            // Check which ID corresponds to which name and store the names
            for (int genreId in genreIds) {
              String genreName = genreMap?[genreId] ?? 'Unknown Genre';
              genreNames.add(genreName);
            }
            return Wrap(
              spacing: 8.0, // adjust spacing between chips
              children: genreNames
                  .map((genreName) => Chip(
                label: Text(
                  genreName,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12),
                ),
                backgroundColor:
                chipColors[genreName.hashCode % chipColors.length],
                // Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                side: BorderSide.none,
              ))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  genreLoading() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(12),
          child: Chip(
            padding: EdgeInsets.all(8),
            label: Text(
              '           ',
              style: TextStyle(
                  fontFamily: 'Poppins', color: Colors.white, fontSize: 12),
            ),
            backgroundColor: index == 0
                ? AppColors.vip
                : index == 1
                ? AppColors.selectedSeat
                : AppColors.regularSeat,
            // Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            side: BorderSide.none,
          ),
        );
      },
    );
  }
}
