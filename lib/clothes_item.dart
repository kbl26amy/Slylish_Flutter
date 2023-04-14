import 'package:flutter/material.dart';
import 'package:flutter_application_1/detailscreen.dart';
import 'model/product.dart';

// ignore: must_be_immutable
class Clothesitem extends StatefulWidget {
  Clothesitem({super.key, required this.product});
  Product product;
  @override
  State<Clothesitem> createState() => _Clothesitem();
}

class _Clothesitem extends State<Clothesitem> {
  late Product product;

  @override
  void initState() {
    //將兩個不同class的變數
    super.initState();
    product = widget.product;
  }

  Widget _clothesContainer(Product product) => Container(
      height: 100,
      width: 400,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      //加上圓角邊框
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        //圖片左邊要切圓角
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
          child: Image.asset(product.mainImage),
        ),
        Flexible(
          child: Column(
              //對齊文字上下置中、左右置左
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //字要貼在一起適應外部約束，不能用Expanded，得用Flexible
                Flexible(
                    child: Text(product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                Flexible(child: Text('${product.price}'))
              ]),
        )
      ]));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(product: product)));
        },
        child: _clothesContainer(product));
  }
}
