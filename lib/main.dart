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
          height: 100,
          width: 400,
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
              Flexible(
                  child: Column(
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
                  ])),
            ],
          ));
  Widget _clothesList(String category) => Column(children: [
        Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 8,
          itemBuilder: (context, index) =>
              _clothesCard('UNIQLO特級極輕羽絨外套', 'NT\$323', 'assets/view.jpeg'),
        ))
      ]);

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
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return _topBanner('assets/view.jpeg');
                    })),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              top: 200,
              left: 0,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.landscape)
                      ? 3
                      : 1,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  var setCategory = ['女裝', '男裝', '配件'];
                  return _clothesList(setCategory[index]);
                },
              ),
            ),
          ],
        ));
  }
}
