import 'dart:js';

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
          //要將主題顏色改成白色，必須使用colorScheme
          colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.white,
              onBackground: Colors.white,
              secondary: Colors.black)),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  //第一排圓角圖片
  Widget _topBanner(String assets) => Container(
      margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(assets), fit: BoxFit.fill)));
  //衣服價目
  Widget _clothesCard(String title, String price, String pic) => Container(
      height: 100,
      width: 500,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0)),
            child: Image.asset('assets/view.jpeg'),
          ),
          Column(
              //對齊文字上下置中、左右置左
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price)
              ]),
        ],
      ));

  Widget _clothesList(String category) => Center(
        child: Column(
          children: [
            Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
            //此處要加上Expanded避免畫面溢出
            Expanded(
                child: _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg')),
            Expanded(
                child: _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg')),
            Expanded(
                child: _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg')),
            Expanded(
                child: _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg')),
            Expanded(
                child: _clothesCard(
                    'UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg')),
          ],
        ),
      );
  @override
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
            SizedBox(
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
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GridView.count(
                //增加部件間距
                childAspectRatio: 0.9,
                //參照畫面直橫方向顯示三個或1個列表
                crossAxisCount: (MediaQuery.of(context).orientation ==
                        Orientation.landscape)
                    ? 3
                    : 1,
                children: [
                  _clothesList('女裝'),
                  _clothesList('男裝'),
                  _clothesList('配件')
                ],
              ),
            ),
          ],
        ));
  }
}
