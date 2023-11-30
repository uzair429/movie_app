import 'package:flutter/material.dart';
import 'package:movies_app/custom_widgets/booking_widgets/seat_selection_widget.dart';

import '../../constants.dart';

class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int timeIntexSelected = 1;

  var time = [
    ["12.30", 50],
    ["13.30", 75],
    ["14.30", 100]
  ];

  Widget _timeItem(String time, int price, bool active) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 0.75),
      decoration: BoxDecoration(
        border: Border.all(
          color: active ? AppColors.borderColor : Colors.grey.withOpacity(.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child:
      // ,
      // Container(
      //   width: 300,
      //     height: 200,
      //     child: SeatSelector()),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chair_alt,size: 200, color: active ? AppColors.borderColor : Colors.black,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      // flex: 17,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * .2),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  time[index][0].toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color:Colors.black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: index == 0 ? 32 : 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        timeIntexSelected = index;
                      });
                    },
                    child: _timeItem(
                        time[index][0].toString(),
                        time[index][1] as int,
                        index == timeIntexSelected ? true : false),
                  ),
                ),
                RichText(
                    text: TextSpan(
                        text: 'From',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.withOpacity(.8),
                        ),
                        children: <TextSpan>[
                      TextSpan(
                        text: ' ${time[index][1].toString()}\$ to ${((time[index][1] as int)* 5).toString()}\$',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    ])),
              ],
            );
          },
        ),
      ),
    );
  }
}
