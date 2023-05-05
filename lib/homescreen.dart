import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/product.dart';
import 'clothes_item.dart';
import 'cubit/homecubit.dart';
import 'profliescreen.dart';

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

    context.read<HomeCubit>().fetchHomeProductLists();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Icon(
                  Icons.account_box_rounded,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, IHomeViewState>(builder: (context, state) {
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
                    var femaleList =
                        StylishCategory("女裝", state.homeViewEntity.femaleList);
                    var maleList =
                        StylishCategory("男裝", state.homeViewEntity.maleList);
                    var accessoryList = StylishCategory(
                        "配件", state.homeViewEntity.accessoryList);

                    switch (index) {
                      case 0:
                        return _clothesList(femaleList, context);
                      case 1:
                        return _clothesList(maleList, context);
                      case 2:
                        return _clothesList(accessoryList, context);
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
