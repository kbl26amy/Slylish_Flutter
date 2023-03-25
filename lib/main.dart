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
      width: 300,
      margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(assets), fit: BoxFit.fill)));
  //衣服價目
  Widget _clothesCard(String title, String price, String pic) =>
      //用Card跟Container寫都可以，但Card外面還再包Sizebox，Container可以直接給尺寸
      Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //加上圓角邊框
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              //圖片左邊要切圓角
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0)),
                child: Image.asset('assets/view.jpeg'),
              ),
              Column(
                  //對齊文字上下置中、左右置左
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //字要貼在一起適應外部約束，不能用Expanded，得用Flexible
                    Flexible(
                        child: Text(title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Flexible(child: Text(price))
                  ]),
            ],
          ));
  Widget _clothesList(String category) => SingleChildScrollView(
        child: SizedBox(
          width: 200,
          height: 700,
          child: Column(
            children: [
              Text(category,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              height: 200,
              width: MediaQuery.of(context).size.width,
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
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              top: 200,
              left: 0,
              child: GridView.count(
                //增加部件間距
                childAspectRatio: 0.8,
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
