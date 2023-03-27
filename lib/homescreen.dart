import 'package:flutter/material.dart';

import 'clothes_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  //第一排圓角圖片
  Widget _topBanner(String assets) => SizedBox(
    width: 350,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(assets, fit: BoxFit.cover),
          ))
    );
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
            // GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     childAspectRatio: 1,
            //     crossAxisCount: (MediaQuery.of(context).orientation ==
            //             Orientation.landscape)
            //         ? 3
            //         : 1,
            //   ),
            //   itemCount: 3,
            //   itemBuilder: (context, index) {
            //     var setCategory = ['女裝', '男裝', '配件'];
            //     return _clothesList(setCategory[index]);
            //   },
            // )
          ],
        ));
  }
}
