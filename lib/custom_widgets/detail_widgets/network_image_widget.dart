import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/movie_provider.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    return CachedNetworkImage(
      imageUrl: provider.selectedMovie!.posterPath,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
      const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: 150,
      ),
    );
  }
}
