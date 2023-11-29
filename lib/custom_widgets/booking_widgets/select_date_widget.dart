import 'package:flutter/material.dart';

import '../../constants.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({Key? key}) : super(key: key);

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  int dateIndexSelected = 1;
  DateTime currentDate = DateTime.now();

  String _dayFormat(int dayWeek) {
    switch (dayWeek) {
      case 1:
        return "MO";
        break;
      case 2:
        return "TU";
        break;
      case 3:
        return "WE";
        break;
      case 4:
        return "TH";
        break;
      case 5:
        return "FR";
        break;
      case 6:
        return "Sa";
        break;
      case 7:
        return "Su";
        break;
      default:
        return "MO";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      // Expanded(
      // flex: 13,
      // child: Container(
      //   width: size.width,
      //   padding: EdgeInsets.only(left:  15),
      //   child: Stack(
      //     alignment: Alignment.centerLeft,
      //     children: [
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.1),
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(12),
            //         bottomLeft: Radius.circular(12),
            //       )),
            // ),
            Container(
              width: size.width,
              height: size.height * .1,
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var date = currentDate.add(Duration(days: index));
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          print('pressed');
                          dateIndexSelected = index;
                        });
                      },
                      child: Container(

                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                          horizontal: 12,
                        ),
                        width: 70,
                        decoration: BoxDecoration(
                          color: dateIndexSelected == index
                              ? AppColors.borderColor
                              : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                  color: index == dateIndexSelected
                                      ? Colors.white
                                      : Colors.black
                                    ),
                            ),
                            Text(
                              _dayFormat(date.weekday),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: index == dateIndexSelected
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
      //     ],
      //   ),
      // ),
    // );
  }
}