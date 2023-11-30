import 'package:flutter/material.dart';
import 'package:movies_app/screen/my_home_screen.dart';
import 'package:provider/provider.dart';
import 'controller/movie_provider.dart';
import 'hive_database/movies_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openHiveBox();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(),
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeScreen(),
    );
  }
}