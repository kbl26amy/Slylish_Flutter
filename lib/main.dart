import 'package:flutter/material.dart';
import 'cubit/homecubit.dart';
import 'cubit/detailcubit.dart';
import 'model/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homescreen.dart';
import 'methodchannel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final IProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(productRepository),
          ),
          BlocProvider<DetailCubit>(
            create: (BuildContext context) => DetailCubit(),
          )
        ],
        child: MaterialApp(
            title: 'Stylish',
            theme: ThemeData(
                //要將主題顏色改成白色，必須使用colorScheme
                colorScheme: const ColorScheme.light(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    onBackground: Colors.white,
                    secondary: Colors.black)),
            debugShowCheckedModeBanner: false,
            home: MyHomePage()));
  }
}
