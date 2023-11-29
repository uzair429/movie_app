import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/custom_widgets/booking_widgets/select_date_widget.dart';

import '../custom_widgets/booking_widgets/time_sellector_widget.dart';

class BookingScreen extends StatefulWidget {
  final movieName;
  const BookingScreen({Key? key,required this.movieName}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
                widget.movieName,
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'
                  ),),
              ],
            ),
          ),
          SelectDateWidget(),
          TimeSelector(),

        ],
      ),
      floatingActionButton: MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

}

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.borderColor,
          onPressed: () {
            // Handle FAB tap
          },
          child: Text('Select Seats'),
        ),
      ),
    );
  }
}
