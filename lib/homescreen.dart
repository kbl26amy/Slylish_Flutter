import 'package:flutter/material.dart';
import 'model/product.dart';
import 'clothes_item.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final mokdata = <StylishCategory>[
    StylishCategory('女裝', <Product>[
      Product(
          '201807202140',
          '透肌砰砰防曬襯衫',
          'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100')
    ]),
    StylishCategory('男裝', <Product>[
      Product(
          '111111',
          '男裝防曬襯衫1',
          '描述',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100'),
      Product(
          '111111',
          '男裝防曬襯衫2',
          '描述',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100')
    ]),
    StylishCategory('配件', <Product>[
      Product(
          '111111',
          '配件防曬襯衫1',
          '描述',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100'),
      Product(
          '111111',
          '配件防曬襯衫2',
          '描述',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100'),
      Product(
          '111111',
          '配件防曬襯衫3',
          '描述',
          '文字',
          '洗滌',
          '中國',
          '注意事項',
          '故事',
          [Colors.red, Colors.blue, Colors.yellow],
          ['S', 'M', 'L'],
          [
            'https://api.appworks-school.tw/assets/201807202140/0.jpg',
            'https://api.appworks-school.tw/assets/201807202140/1.jpg',
            'https://api.appworks-school.tw/assets/201807202140/0.jpg'
          ],
          'assets/clothes.jpeg',
          '100')
    ])
  ];

  //第一排圓角圖片
  Widget _topBanner(String assets) => Container(
      width: 350,
      margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(assets), fit: BoxFit.fill)));

  Widget _clothesList(StylishCategory category, BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenwidth > 700;
    Widget productList = getClothesListView(isWideScreen, category);
    double wideScreenItemWidth = screenwidth / 3;

    return isWideScreen
        ? SizedBox(
            width: wideScreenItemWidth,
            child: Column(children: [
              Text(category.category,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: productList)
            ]))
        : Column(
            children: [
              Text(category.category,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              productList
            ],
          );
  }

  Widget getClothesListView(bool isWideScreen, StylishCategory category) {
    return ListView.builder(
        shrinkWrap: !isWideScreen,
        scrollDirection: Axis.vertical,
        itemCount: category.productList.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Clothesitem(product: category.productList[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 700;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return _topBanner('assets/view.jpeg');
                  }),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: isWideScreen ? Axis.horizontal : Axis.vertical,
                itemCount: mokdata.length,
                itemBuilder: (context, index) {
                  return _clothesList(mokdata[index], context);
                },
              ),
            ),
          ],
        ));
  }
}
