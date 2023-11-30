import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/custom_widgets/booking_widgets/seat_selection_widget.dart';

class SeatsSelectionScreen extends StatefulWidget {
  const SeatsSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SeatsSelectionScreen> createState() => _SeatsSelectionScreenState();
}

class _SeatsSelectionScreenState extends State<SeatsSelectionScreen> {

  var _chairStatus = [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 3, 1, 1],
    [1, 1, 1, 1, 1, 3, 3],
    [2, 2, 2, 1, 3, 1, 1],
    [1, 1, 1, 1, 2, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [2, 2, 2, 1, 3, 1, 1],
    [1, 1, 1, 1, 1, 3, 3],
    [2, 2, 2, 1, 3, 1, 1],
    [4, 4, 4, 4, 4, 4, 4],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
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
                      color: Colors.black,
                    )),
                // SizedBox(width: 6,),
                Column(
                  children: [
                    Text(
                      'widget.movieName',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      'Movie in Threater',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ],
            ),
          )),
          SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: SeatSelector()),
        ],
      ),
      // body: SeatsSelectionScreen(),
    );
  }
}
