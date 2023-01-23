import 'package:commit_creator_utility/widgets/form_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Color.fromARGB(20, 0, 0, 0),
        body: CCForm(),
      ),
    );
  }
}
