import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';

import 'build_chair_widget.dart';

class SeatSelector extends StatefulWidget {
  // final chairList;
  // SeatSelector();
  @override
  _SeatSelectorState createState() => _SeatSelectorState();
}

class _SeatSelectorState extends State<SeatSelector> {

  Widget _chairList(){

   Size size = MediaQuery.of(context).size;

    // var _chairStatus = widget.chairList;
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

    return Column(
      children: <Widget>[
        for (int i = 0; i < 10; i++)
          Container(
           margin: EdgeInsets.only(top: i == 3 ? size.height * .01 : 0),
            child: Row(
              children: <Widget>[
                for (int x = 0; x < 9; x++)
                  Expanded(
                    flex: x == 0 || x == 8 ? 4 : 1,
                    child: x == 0 ||
                        x == 8 ||
                        (i == 0 && x == 1) ||
                        (i == 0 && x == 7) ||
                        (x == 4)
                        ? Container()
                        : Container(
                    //  height: size.width / 11 - 10,
                     // margin: EdgeInsets.all(1),
                      child: _chairStatus[i][x - 1] == 1
                          ? BuildChairs.regularChair()
                          : _chairStatus[i][x - 1] == 2
                          ? BuildChairs.selectedChair() :
                            _chairStatus[i][x - 1] == 3 ?
                           BuildChairs.reservedChair()
                           :BuildChairs.vipChair(),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          ClipPath(
                clipper: TopCurveClipper(),
                child: Container(
                  width: 350,
                  height: 50.0, // Adjust the height of the curved part
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, Colors.white], // Gradient colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
          Text('Screen',style: TextStyle(color: Colors.black),),
          //Movie white Screen ends
          _chairList(),
        ],
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 20); // Start at the top-left
    path.quadraticBezierTo(size.width / 2, -20, size.width, 20); // Curved part
    path.lineTo(size.width, size.height); // End at the bottom-right
    path.lineTo(0, size.height); // End at the bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}