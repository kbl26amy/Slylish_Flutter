import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish',
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  //第一排圓角圖片
  Widget _imageContainer(String assets) => Container(
      margin: EdgeInsets.only(left: 5, top: 20, right: 5),
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image:
              DecorationImage(image: AssetImage(assets), fit: BoxFit.cover)));

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
        ),
        body: Container(
          height: 200,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
              ]),
        ));
  }
}
