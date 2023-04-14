import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/product.dart';
import 'clothes_item.dart';
import 'model/datacubit.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomePageViewEntity mockData = HomePageViewEntity();

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

    context.read<ProductCubit>().fetchFemaleData();

    // mockData.updateFemaleList(<Product>[
    //   Product(
    //       201807202140,
    //       '透肌砰砰防曬襯衫',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100)
    // ]);

    // mockData.updateMaleList(<Product>[
    //   Product(
    //       111111,
    //       '男裝防曬襯衫1',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100),
    //   Product(
    //       111111,
    //       '男裝防曬襯衫2',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100)
    // ]);

    // mockData.updateAcceList(<Product>[
    //   Product(
    //       111111,
    //       '配件防曬襯衫1',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100),
    //   Product(
    //       111111,
    //       '配件防曬襯衫2',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100),
    //   Product(
    //       111111,
    //       '配件防曬襯衫3',
    //       'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
    //       '薄',
    //       '棉100%',
    //       '中國',
    //       '中國',
    //       '無',
    //       [Colors.red, Colors.blue, Colors.yellow],
    //       ['S', 'M', 'L'],
    //       [
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //         'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989__480.jpg',
    //       ],
    //       'assets/clothes.jpeg',
    //       100)
    // ]);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
        ),
        body: BlocBuilder<ProductCubit, DataState>(builder: (context, state) {
          return Column(
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
                  scrollDirection:
                      isWideScreen ? Axis.horizontal : Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    var catagory = StylishCategory("", <Product>[]);

                    if (state is FemaleDataLoaded) {
                      catagory = state.femaleCatory;
                    }

                    switch (index) {
                      case 0:
                        return _clothesList(catagory, context);
                      case 1:
                        return _clothesList(mockData.maleCategory, context);
                      case 2:
                        return _clothesList(mockData.acceCategory, context);
                      default:
                        throw Exception("Undefine category");
                    }
                  },
                ),
              ),
            ],
          );
        }));
  }
}
