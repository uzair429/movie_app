import 'package:flutter/material.dart';

import '../../constants.dart';

class BuildChairs{
  static Widget selectedChair(){
    return Icon(Icons.chair_alt,color: AppColors.selectedSeat,);
  }

  static Widget regularChair(){
    return Icon(Icons.chair_alt,color: AppColors.regularSeat,);
  }

  static Widget reservedChair(){
    return Icon(Icons.chair_alt,color: AppColors.notAvailable,);
  }
  static Widget vipChair(){
    return Icon(Icons.chair_alt,color: AppColors.vip,);
  }
}