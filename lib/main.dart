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
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.white,
              onBackground: Colors.white,
              secondary: Colors.black)),
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

  Widget _buildDecoratedImage(String title, String price, String pic) =>
      Expanded(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.black38)),
            child: Row(children: [
              Image.asset(pic),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(price),
                ],
              ),
            ])),
      );
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
        ),
        body: ListView(
          children: [
            //為了設定高度用Container包起來
            Container(
              height: 200,
              //讓圖片可以往右滑動，把Row改成ListView
              child: ListView(scrollDirection: Axis.horizontal, children: [
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
                _imageContainer('assets/view.jpeg'),
              ]),
            ),
            _buildDecoratedImage('衣服標題', '價格', 'assets/clothes.jpeg')
          ],
        ));
  }
}
