import 'package:flutter/material.dart';
import 'package:flutter_application_1/clothes_item.dart';

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

  Widget _clothesList(String category, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 700;
    Widget productList = getClothesListView(isWideScreen);
    // calculate width to fit full screen size
    double wideScreenItemWidth = (screenWidth) / 3;

    return isWideScreen
        ? SizedBox(
            width: wideScreenItemWidth,
            child: Column(
                children: [Text(category), Expanded(child: productList)]))
        : Column(
            children: [Text(category), productList],
          );
  }

  Widget getClothesListView(bool isWideScreen) {
    return ListView.builder(
        shrinkWrap: !isWideScreen,
        scrollDirection: Axis.vertical,
        itemCount: 8,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          return const Clothesitem();
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  var setCategory = ['女裝', '男裝', '配件'];
                  return _clothesList(setCategory[index], context);
                },
              ),
            )
          ],
        ));
  }
}
