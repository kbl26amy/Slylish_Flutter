import 'package:flutter/material.dart';

class Clothesitem extends StatefulWidget {
  const Clothesitem({super.key});
  @override
  State<Clothesitem> createState() => _Clothesitem();
}

Widget _clothesContainer(String title, String pic, String price) => Container(
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
        child: Image.asset(pic),
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
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              Flexible(child: Text(price))
            ]),
      )
    ]));

class _Clothesitem extends State<Clothesitem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detailpage');
        },
        child: _clothesContainer(
            'UNIQLO特級極輕羽絨外套', 'assets/clothes.jpeg', 'NT\$323'));
  }
}
