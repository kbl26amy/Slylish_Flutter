import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/item_detail_cubit.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.product});
  final Product product;

  Widget colorView() => Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              const Text(
                '顏色',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const Flexible(
                child: VerticalDivider(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: DecoratedBox(
                              decoration:
                                  BoxDecoration(color: product.colors[index]),
                            ),
                          ),
                        );
                      }),
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
            Expanded(
              child: SizedBox(
                  height: 25,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.sizes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            // Change the button size
                            width: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // ElevatedButton styles
                                  padding: const EdgeInsets.all(
                                      8), // Some padding example
                                  shape: RoundedRectangleBorder(
                                    // Border
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {},
                                child: Text(product.sizes[index]),
                              ),
                            ));
                      })),
            ),
          ]),
        ),
      );

  Widget countView(BuildContext context, double width) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: 30,
          width: width,
          child: Expanded(
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
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Material(
                      color: Colors.black54,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () =>
                            context.read<ItemDetailCubit>().decrement(),
                        child: const Center(
                            child: Icon(Icons.remove_circle,
                                color: Colors.black, size: 18)),
                      ),
                    ),
                  ),
                ),
                Expanded(child: BlocBuilder<ItemDetailCubit, Order>(
                    builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: TextEditingController()
                      ..text = state.count.toString(),
                  );
                })),
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Material(
                      color: Colors.black54,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () =>
                            context.read<ItemDetailCubit>().increment(),
                        child: const Center(
                            child: Icon(Icons.add_circle,
                                color: Colors.black, size: 18)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget chooseView(BuildContext context, double width) => SizedBox(
        height: 350,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text('${product.id}',
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
              Text('''\nNT\$${product.price}''',
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const Flexible(child: Divider(color: Colors.black38)),
              Flexible(child: colorView()),
              Flexible(child: sizeView()),
              Expanded(child: countView(context, width)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(width, 40),
                    backgroundColor: Colors.black,
                    // foreground
                  ),
                  onPressed: () {},
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
          Row(children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.indigoAccent, Colors.cyan],
              ).createShader(bounds),
              child: const Text(
                '細部說明',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
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

  Widget detailpage(BuildContext context, bool isWideScreen) {
    return isWideScreen
        ? ListView(children: [
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  product.mainImage,
                  height: 350,
                ),
                chooseView(context, 300),
              ]),
              detail(),
            ]),
          ])
        : ListView(children: [
            Column(children: [
              Image.asset(
                product.mainImage,
                height: 350,
              ),
              chooseView(context, 600),
              detail(),
            ]),
          ]);
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
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: detailpage(context, isWideScreen)),
      ),
    );
  }
}
