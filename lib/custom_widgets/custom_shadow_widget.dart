import 'package:flutter/material.dart';

class CustomShadowWidget extends StatelessWidget {
  bool isDetail;
   CustomShadowWidget({Key? key,required this.isDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: isDetail ? size.height * 0.3 : size.height * 0.1,
        // Adjust the height of the overlay
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent
            ],
          ),
        ),
      ),
    );
  }
}
