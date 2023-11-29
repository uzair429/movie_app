import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screen/booking_screen.dart';
import 'package:movies_app/screen/videoScreen.dart';

import '../constants.dart';

class DetailScreen extends StatelessWidget {
  final movie;

  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color:  AppColors.backgroundColor,
            height: size.height * .75,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: networkImage(),
                ),
                arrowButtonAndText(context),
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
                              ticketButton(context);
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
                                side:
                                    const BorderSide(color: AppColors.borderColor),
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
        Row(
          children: [
            Padding(padding: const EdgeInsets.all(18.0), child: overViewText()),
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: detailOverViewText())
      ]),
    );
  }

  _buildLandscapeLayout(context) {
    final size = MediaQuery.of(context).size;
    return Row(children: [
      Expanded(
        child: Container(
            color:  AppColors.backgroundColor,
            child: Stack(
              children: [
                networkImage(),
                arrowButtonAndText(context),
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
                              ticketButton(context);
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
                        margin: EdgeInsets.all(12),
                        height: 50,
                        width: size.width * .25,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              videoButton(context);
                            },
                            style: ElevatedButton.styleFrom(
                                side:
                                    const BorderSide(color: AppColors.borderColor),
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
                )
              ],
            )),
      ),
      Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  overViewText(),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: detailOverViewText()),
          ],
        ),
      )
    ]);
  }

  ticketButton(context){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return BookingScreen(
        movieName: movie.title,
      );
    }));
  }
  videoButton(context){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return VideoPlayerScreen(
        movieId: movie.id,
      );
    }));
  }

  networkImage(){
    return
      CachedNetworkImage(
        imageUrl: movie.posterPath,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error,size: 150,),
      );
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
    return const Text(
      'Overview',
      style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins'),
    );
  }

  detailOverViewText() {
    return Text(
      movie.overview,
      style: const TextStyle(
          fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
    );
  }
}
