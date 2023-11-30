import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/movie_provider.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        provider.selectedMovie!.overview,
        style: const TextStyle(
            fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
      ),
    );
  }
}
