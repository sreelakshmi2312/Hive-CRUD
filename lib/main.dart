import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivecrud/models/listModel.dart';
import 'Screens/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //ensuring initialization 
  await Hive.initFlutter();  //initializing hive at beginning
  Hive.registerAdapter(listItemsAdapter());   // registering the adapter for listItems
  await Hive.openBox<listItems>('student_db');   // creating a new table
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
