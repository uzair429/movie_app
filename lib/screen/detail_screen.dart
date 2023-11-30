import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/controller/movie_provider.dart';
import 'package:movies_app/custom_widgets/custom_shadow_widget.dart';
import 'package:movies_app/custom_widgets/detail_widgets/genre_widget.dart';
import 'package:movies_app/custom_widgets/detail_widgets/overview_widget.dart';
import 'package:movies_app/screen/videoScreen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../custom_widgets/detail_widgets/network_image_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: arrowButtonAndText(context)),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortraitLayout(context);
        } else {
          return _buildLandscapeLayout(context);
        }
      }),
    );
  }

  _buildPortraitLayout(context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        Container(
            color: AppColors.backgroundColor,
            height: size.height * .75,
            child: Stack(
              children: [
                const SizedBox.expand(
                  child: NetworkImageWidget(),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 0.3,
                    // Adjust the height of the overlay
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
                CustomShadowWidget(
                  isDetail: true,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 230,
                        child: ElevatedButton(
                            onPressed: () {
                              // ticketButton(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.borderColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text(
                              'Get Ticket',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(12),
                        height: 50,
                        width: 230,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              videoButton(context);
                            },
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.borderColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Watch Trailer',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )),
                      )
                    ],
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            genreText(),
            const GenreWidget(),
            overViewText(),
            const OverviewWidget(),
          ]),
        )
      ]),
    );
  }

  _buildLandscapeLayout(context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Row(children: [
      Expanded(
        child: Container(
            color: AppColors.backgroundColor,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: provider.selectedMovie!.posterPath,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 150,
                  ),
                ),
                // arrowButtonAndText(context),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                        width: size.width * .2,
                        child: ElevatedButton(
                            onPressed: () {
                              // ticketButton(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.borderColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: Text(
                              'Get Ticket',
                              style: TextStyle(
                                  fontSize: size.width * .02,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(12),
                        height: 50,
                        width: size.width * .25,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              videoButton(context);
                            },
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.borderColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Watch Trailer',
                              style: TextStyle(
                                  fontSize: size.width * .02,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            genreText(),
            const GenreWidget(),
            overViewText(),
            const OverviewWidget()
          ],
        ),
      )
    ]);
  }

  // ticketButton(context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //     return BookingScreen(
  //       movieName: movie.title,
  //     );
  //   }));
  // }

  videoButton(context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoPlayerScreen(
        movieId: provider.selectedMovie!.id,
      );
    }));
  }

  arrowButtonAndText(context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          // SizedBox(width: 6,),
          const Text(
            'Watch',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ],
      ),
    ));
  }

  overViewText() {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Text(
        'Overview',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'),
      ),
    );
  }

  genreText() {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Text(
        'Genre',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'),
      ),
    );
  }
}
