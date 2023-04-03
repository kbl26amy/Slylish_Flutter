import 'package:flutter/material.dart';
import 'model/product.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  var product = Product(
      '111111',
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
        'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989_1280.jpg',
        'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989_1280.jpg',
        'https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989_1280.jpg'
      ],
      'assets/view.jpeg',
      '100');
  Widget sizeButton(String size) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onPressed: null,
      child: Text(size));
  Widget colorView() => SizedBox(
        height: 30,
        child: Row(
          children: const [
            Text(
              '顏色',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            Flexible(
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ],
        ),
      );
  Widget sizeView() => SizedBox(
        height: 30,
        child: Row(children: [
          Text(
            '尺寸',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          Flexible(
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          sizeButton('S'),
          sizeButton('M'),
          sizeButton('L')
        ]),
      );

  Widget countView() => SizedBox(
        height: 30,
        child: Row(
          children: [
            Text(
              '數量',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            Flexible(
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            IconButton(onPressed: null, icon: Icon(Icons.add_circle))
          ],
        ),
      );
  Widget chooseView() => SizedBox(
        height: 300,
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(product.id,
                style: const TextStyle(fontSize: 12, color: Colors.black)),
            Text("NT\$100",
                style: const TextStyle(fontSize: 14, color: Colors.black)),
            const Divider(color: Colors.black38),
            Flexible(child: colorView()),
            Flexible(child: sizeView()),
            Flexible(child: countView()),
          ],
        ),
      );

  Widget detail() {
    return SizedBox(
      width: 600,
      child: Column(children: [
        Row(children: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text('細部說明',
                style: TextStyle(color: Colors.brown, fontSize: 12)),
          ),
          Expanded(
            child: Divider(
              color: Colors.black38,
            ),
          )
        ]),
        Text(product.description,
            style: const TextStyle(color: Colors.black38, fontSize: 10)),
        ListView.builder(
            shrinkWrap: true,
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.network(
                  product.images[index],
                  height: 300,
                  width: 600,
                  fit: BoxFit.cover,
                ),
              );
            }),
      ]),
    );
  }

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
        body: SizedBox(
          width: 800,
          child: ListView(children: [
            Column(children: [
              Image.asset(
                product.mainImage,
                height: 400,
              ),
              chooseView(),
              detail(),
            ]),
          ]),
        ));
  }
}
