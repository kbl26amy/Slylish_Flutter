import 'package:flutter/material.dart';
import 'clothes_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  //第一排圓角圖片
  Widget _topBanner(String assets) => Container(
      width: 350,
      margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(assets), fit: BoxFit.fill)));
  //衣服價目

  Widget _clothesList(String category) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
        //這邊一定要加上Expanded，不然會不知道尺寸報error
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (context, index) => const Clothesitem()))
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
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return _topBanner('assets/view.jpeg');
                    })),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              top: 200,
              left: 0,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
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
