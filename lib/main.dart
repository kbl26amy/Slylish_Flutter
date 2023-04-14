import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/datacubit.dart';
import 'package:flutter_application_1/model/item_detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
            create: (BuildContext context) => ProductCubit(),
          ),
          BlocProvider<ItemDetailCubit>(
            create: (_) => ItemDetailCubit(),
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
