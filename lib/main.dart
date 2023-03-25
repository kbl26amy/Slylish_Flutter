import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'detailScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish',
      theme: ThemeData(
          //要將主題顏色改成白色，必須使用colorScheme
          colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.white,
              onBackground: Colors.white,
              secondary: Colors.black)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/detailpage': (context) => const DetailPage(),
      },
    );
  }
}
