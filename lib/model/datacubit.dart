import 'package:bloc/bloc.dart';
import 'product.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductCubit extends Cubit<DataState> {
  ProductCubit() : super(DataInitial());

  void fetchFemaleData() async {
    emit(DataLoading());
    Dio dio = Dio();
    try {
      Response response = await dio
          .get('https://api.appworks-school.tw/api/1.0/products/women');
      if (response.statusCode == 200) {
        dynamic jsonString = jsonDecode(response.toString());
        List<Product> products = List<Product>.from(
            jsonString["data"].map((model) => Product.fromMap(model)));
        emit(FemaleDataLoaded(femaleCatory: StylishCategory("女裝", products)));

        print("The response is that \n${response.data}\n");
      } else {
        print("123456/");
      }
    } catch (e) {
      print("123456/" + "$e");
    }
  }
}

//定義好state
class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class FemaleDataLoaded extends DataState {
  FemaleDataLoaded({required this.femaleCatory});
  StylishCategory femaleCatory;
}


  // void updateFemaleList(List<Product> list) {
  //   femaleCategory.productList.clear();
  //   femaleCategory.productList.addAll(list);
  // }

  // void updateMaleList(List<Product> list) {
  //   maleCategory.productList.clear();
  //   maleCategory.productList.addAll(list);
  // }

  // void updateAcceList(List<Product> list) {
  //   acceCategory.productList.clear();
  //   acceCategory.productList.addAll(list);
  // }

