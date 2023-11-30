import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

part 'movies_database.g.dart';
//
@HiveType(typeId: 0)
class MovieCacheData extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String overview;

  @HiveField(3)
  String posterPath;

  @HiveField(4)
  String backdropPath;

  @HiveField(5)
  List<int> genres;

  @HiveField(6)
  String releaseDate;

  MovieCacheData({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genres,
    required this.releaseDate,
  });
}



class HiveBoxes {
  static const String movies = 'movies';
}

Future<void> openHiveBox() async {
  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<MovieCacheData>(MovieCacheDataAdapter());
  await Hive.openBox<MovieCacheData>(HiveBoxes.movies,);
}

Future<void> closeHiveBox() async {
  await Hive.close();
}
