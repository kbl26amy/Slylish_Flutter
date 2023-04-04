import 'package:flutter/material.dart';
import 'model/product.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.product});
  final Product product;
  Widget sizeButton(String size) => TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onPressed: null,
      child: Text(
        size,
        style: const TextStyle(color: Colors.white),
      ));
  Widget colorView() => Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: SizedBox(
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
        ),
      );
  Widget sizeView() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: 30,
          child: Row(children: [
            const Text(
              '尺寸',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const Flexible(
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            sizeButton('S'),
            sizeButton('M'),
            sizeButton('L')
          ]),
        ),
      );

  Widget countView() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: 30,
          width: 600,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '數量',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const Flexible(
                child: VerticalDivider(
                  color: Colors.grey,
                ),
              ),
              Stack(children: const [
                SizedBox(
                  width: 60.0,
                  height: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child:
                      IconButton(onPressed: null, icon: Icon(Icons.add_circle)),
                )),
              ]),
              const Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '1',
                  ),
                ),
              ),
              Stack(children: const [
                SizedBox(
                  width: 60.0,
                  height: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child:
                      IconButton(onPressed: null, icon: Icon(Icons.add_circle)),
                )),
              ]),
            ],
          ),
        ),
      );
  Widget chooseView() => SizedBox(
        height: 350,
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(product.id,
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
              Text('''\nNT\$${product.price}''',
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const Divider(color: Colors.black38),
              Flexible(child: colorView()),
              Flexible(child: sizeView()),
              Flexible(child: countView()),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(600, 40),
                    backgroundColor: Colors.black,
                    // foreground
                  ),
                  onPressed: null,
                  child: const Text(
                    '請選擇尺寸',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Expanded(
                  child: Text(
                      '''實品顏色依單品照為主 \n${product.wash} \n厚薄：${product.texture} \n彈性：${product.story}\n素材產地/${product.place}\n加工產地/${product.note}''',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      );

  Widget detail() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(children: const [
            Text('細部說明', style: TextStyle(color: Colors.brown, fontSize: 12)),
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
                    height: 250,
                    width: 600,
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ]),
      ),
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
        body: Center(
          child: SizedBox(
            width: 800,
            child: ListView(children: [
              Column(children: [
                Image.asset(
                  product.mainImage,
                  height: 350,
                ),
                chooseView(),
                detail(),
              ]),
            ]),
          ),
        ));
  }
}
