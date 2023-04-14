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
        print(response.data);
      } else {}
    } catch (e) {}
  }
}

//定義好state
class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  StylishCategory femaleCategory = StylishCategory("女裝", <Product>[]);
  StylishCategory maleCategory = StylishCategory("男裝", <Product>[]);
  StylishCategory acceCategory = StylishCategory("配件", <Product>[]);

  void updateFemaleList(List<Product> list) {
    femaleCategory.productList.clear();
    femaleCategory.productList.addAll(list);
  }

  void updateMaleList(List<Product> list) {
    maleCategory.productList.clear();
    maleCategory.productList.addAll(list);
  }

  void updateAcceList(List<Product> list) {
    acceCategory.productList.clear();
    acceCategory.productList.addAll(list);
  }
}
