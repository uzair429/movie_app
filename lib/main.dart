import 'package:flutter/material.dart';
import 'package:movies_app/screen/my_home_screen.dart';
import 'hive_database/movies_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openHiveBox(); // Open and initialize Hive box before runApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeScreen(),
    );
  }
}