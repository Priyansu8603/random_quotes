import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes/features/homescreen/View/HomePage.dart';
import 'package:random_quotes/features/homescreen/ViewModel/HomePageViewModel.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomePageViewModel(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
