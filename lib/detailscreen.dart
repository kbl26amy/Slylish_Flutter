import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/detailcubit.dart';
import 'package:flutter_application_1/cartscreen';
import 'arkit.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

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
                  width: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<String> colorList =
                            product.colors.map((color) => color.code).toList();

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: BlocBuilder<DetailCubit, IDetailViewState>(
                              builder: (context, state) {
                            var isSelectedColor = false;
                            if (colorList[index] == state.order.color) {
                              isSelectedColor = true;
                            }
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  // ElevatedButton styles
                                  padding: const EdgeInsets.all(8),
                                  backgroundColor: colorList[index].toColor(),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                                  side: BorderSide(
                                      width: 1,
                                      color: isSelectedColor
                                          ? Colors.black87
                                          : Colors.transparent)),
                              onPressed: () {
                                context
                                    .read<DetailCubit>()
                                    .updateColor(colorList[index]);
                              },
                              child: null,
                            );
                          }),
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
                            child: BlocBuilder<DetailCubit, IDetailViewState>(
                                builder: (context, state) {
                              var isSelectedSize = false;
                              if (product.sizes[index] == state.order.size) {
                                isSelectedSize = true;
                              }
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // ElevatedButton styles
                                    padding: const EdgeInsets.all(
                                        8), // Some padding example
                                    shape: RoundedRectangleBorder(
                                      // Border
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    backgroundColor: isSelectedSize
                                        ? Colors.black87
                                        : Colors.grey),
                                onPressed: () {
                                  context
                                      .read<DetailCubit>()
                                      .updateSize(product.sizes[index]);
                                },
                                child: Text(product.sizes[index]),
                              );
                            }),
                          ),
                        );
                      })),
            ),
          ]),
        ),
      );

  Widget countView(BuildContext context, double width) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: 25,
          width: width,
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
                      onTap: () => context.read<DetailCubit>().decreaseAmount(),
                      child: const Center(
                          child: Icon(Icons.remove_circle,
                              color: Colors.black, size: 18)),
                    ),
                  ),
                ),
              ),
              Expanded(child: BlocBuilder<DetailCubit, IDetailViewState>(
                  builder: (context, state) {
                String _currentText = "";
                final controller = TextEditingController();
                final amount = state.order.amount.toString();
                controller.text = amount;
                controller.selection =
                    TextSelection.collapsed(offset: amount.length);
                return TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      _currentText = text;
                      context.read<DetailCubit>().updateAmount(int.parse(text));
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: controller);
              })),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: Material(
                    color: Colors.black54,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () => context.read<DetailCubit>().increaseAmount(),
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
              countView(context, width),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 25,
                  width: width,
                  child: BlocBuilder<DetailCubit, IDetailViewState>(
                      builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // Some padding example
                          shape: RoundedRectangleBorder(
                            // Border
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Colors.black54),
                      onPressed: () {
                        context.read<DetailCubit>().isOrderValid()
                            ? {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CartPage(
                                                product: product,
                                                order: state.order)))
                              }
                            : {};
                      },
                      child: Text(context.read<DetailCubit>().isOrderValid()
                          ? "前往購物車"
                          : "請選擇正確 顏色/尺寸/數量"),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 100,
                child: Text(
                    '''${product.wash} \n${product.texture} \n${product.description}\n素材產地/${product.place}\n${product.note}''',
                    style: const TextStyle(fontSize: 12, color: Colors.black)),
              ),
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
          Text(product.story,
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
                Image.network(
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
              Image.network(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ARKitPage()));
              },
              child: Icon(
                Icons.accessibility,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: detailpage(context, isWideScreen)),
      ),
    );
  }
}
