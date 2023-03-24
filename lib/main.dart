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
  Widget _topBanner(String assets) => Container(
      margin: EdgeInsets.only(left: 5, top: 20, right: 5),
      width: 400,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image:
              DecorationImage(image: AssetImage(assets), fit: BoxFit.cover)));
  //衣服價目
  Widget _clothesCard(String title, String price, String pic) =>
      //使用Card跟Container，會讓裡面的圖片無法切圓角
      Container(
          height: 100,
          width: 420,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.black38)),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.asset(pic),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(price),
                ],
              ),
            ]),
          ));
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
          scrollDirection: Axis.vertical,
          children: [
            //為了設定高度用Container包起來
            Container(
              height: 200,
              //讓圖片可以往右滑動，把Row改成ListView
              child: ListView(scrollDirection: Axis.horizontal, children: [
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
                _topBanner('assets/view.jpeg'),
              ]),
            ),
            Column(
              children: [
                Text('女裝', style: TextStyle(fontWeight: FontWeight.bold)),
                _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/clothes.jpeg'),
                _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/clothes.jpeg'),
                _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/clothes.jpeg'),
                _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/clothes.jpeg'),
                _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/clothes.jpeg'),
              ],
            ),
          ],
        ));
  }
}
