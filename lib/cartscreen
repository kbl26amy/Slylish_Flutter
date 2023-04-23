import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/product.dart';
import 'cubit/detailcubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required Product product, required Order order})
      : _order = order,
        _product = product;

  final Order _order;
  final Product _product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<DetailCubit, IDetailViewState>(
                builder: (context, state) {

              final isCardInfoValid = state.order.primeResult.isNotEmpty &&
                  !state.order.primeResult.startsWith("error");
              print("123456/" + state.order.primeResult );

              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    getOrderDetailSection(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            backgroundColor: Colors.black54),
                        onPressed: () {
                          context.read<DetailCubit>().startPay();
                        },
                        child: const Text("編輯卡片資訊"),
                      ),
                    ),
                    Text(
                        state.order.primeResult.isEmpty
                            ? ""
                            : isCardInfoValid
                                ? "${"卡片資訊輸入成功！"}\nprime = ${_order.primeResult}"
                                : "${"卡片資訊輸入錯誤，請重新輸入卡片資訊"}\n${_order.primeResult}",
                        style: TextStyle(
                            color:
                                isCardInfoValid ? Colors.black : Colors.red)),
                    Visibility(
                      visible: isCardInfoValid,
                      child: SizedBox(
                        width: double.infinity,
                        height:50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              backgroundColor: Colors.black54),
                          onPressed: () {
                            context.read<DetailCubit>().clearOrder();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("付款成功"),
                            ));
                          },
                          child: const Text("確認付款"),
                        ),
                      ),
                    ),
                  ]));
            })));
  }

  Widget getOrderDetailSection() {
    return SizedBox(
        height: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              _product.mainImage,
              width:200,
              fit: BoxFit.cover,
            ),
            Expanded(
                // to make text width flexible without overflow
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_product.title),
                          Text(_product.id.toString()),
                          Text("${"顏色"} | ${_order.color}"),
                          Text("${"尺寸"} | ${_order.size}"),
                        ]))),
            Expanded(
                // to make text width flexible without overflow
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "${"單價："}${_product.price}"),
                          Text("${ "數量："}${_order.amount}"),
                          Text(
                              "${ "總價："}${_product.price * _order.amount}"),
                        ])))
          ],
        ));
  }
}