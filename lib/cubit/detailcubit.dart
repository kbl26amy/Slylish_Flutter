import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

class Order {
  String id = "";
  String color = "";
  String size = "";
  int amount = 0;
  String primeResult = "";

  Order(this.id, this.color, this.size, this.amount, this.primeResult);

  factory Order.from(Order order) =>
      Order(order.id, order.color, order.size, order.amount, order.primeResult);
}

abstract class IDetailViewState {
  final Order order;

  IDetailViewState(this.order);
}

class OrderUpdated extends IDetailViewState {
  OrderUpdated(super.order);
}

class DetailCubit extends Cubit<IDetailViewState> {
  Order order = Order("", "", "", 0, "");

  DetailCubit() : super(OrderUpdated(Order("", "", "", 0, "")));

  void clearOrder() {
    order = Order("", "", "", 0, "");
    emit(OrderUpdated(order));
  }

  void updateColor(String selectedColor) {
    order.color = selectedColor;
    emit(OrderUpdated(order));
  }

  void updateSize(String selectedSize) {
    order.size = selectedSize;
    emit(OrderUpdated(order));
  }

  void updateAmount(int totalAmount) {
    order.amount = totalAmount;
    emit(OrderUpdated(order));
  }

  void increaseAmount() {
    order.amount = order.amount + 1;
    emit(OrderUpdated(order));
  }

  void decreaseAmount() {
    if (order.amount > 0) {
      order.amount = order.amount - 1;
    } else {
      order.amount = 0;
    }
    emit(OrderUpdated(order));
  }

  bool isOrderValid() {
    return order.color.isNotEmpty && order.size.isNotEmpty && order.amount > 0;
  }

  void startPay() async {
    const platformMethodChannel = MethodChannel('flutterChannel');
    order.primeResult = await platformMethodChannel.invokeMethod(
        "startTapPaySetting",
        {"cardNumber": "", "dueMonth": "", "dueYear": "", "cvv": ""});
    emit(OrderUpdated(order));
  }
}

/// {@template item_detail_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class ItemDetailCubit extends Cubit<ChooseOrder> {
  /// {@macro item_detail_cubit}
  ItemDetailCubit() : super(ChooseOrder());

  /// Add 1 to the current state.
  void increment() => emit(state.copyWith(count: state.count + 1));

  /// Subtract 1 from the current state.
  void decrement() =>
      emit(state.count == 0 ? state : state.copyWith(count: state.count - 1));

  void setSize(ColthesSize size) => emit(state.copyWith(size: size));
}

enum ColthesSize { DEFAULT, S, M, L }

class ChooseOrder {
  final int count;
  final ColthesSize size;

  ChooseOrder({this.count = 0, this.size = ColthesSize.DEFAULT});

  ChooseOrder copyWith({int? count, ColthesSize? size}) => ChooseOrder(
        count: count ?? this.count,
        size: size ?? this.size,
      );
}
