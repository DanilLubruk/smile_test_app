import 'package:flutter/material.dart';
import 'package:smile_test_app/di/app_component.dart';
import 'package:smile_test_app/ui/lists/news_list_screen.dart';

void main() async{
  await AppComponent.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: const NewsListScreen(),
    );
  }
}