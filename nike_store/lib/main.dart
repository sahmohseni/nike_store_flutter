import 'package:flutter/material.dart';
import 'package:nike_store/src/core/network/di/network_module.dart';
import 'package:nike_store/src/data/di/api_module.dart';
import 'package:nike_store/src/domain/di/repo_module.dart';

void main() {
  networkInjector();
  apiInjector();
  repoInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              headline6: TextStyle(fontFamily: 'dana'),
              caption: TextStyle(fontFamily: 'dana', color: Colors.grey),
              bodyText2: TextStyle(
                fontFamily: 'dana',
              ))),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
