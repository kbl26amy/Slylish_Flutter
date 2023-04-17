
import 'package:bloc/bloc.dart';

/// {@template item_detail_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class ItemDetailCubit extends Cubit<Order> {
  /// {@macro item_detail_cubit}
  ItemDetailCubit() : super(Order());

  /// Add 1 to the current state.
  void increment() => emit(state.copyWith(count: state.count + 1));

  /// Subtract 1 from the current state.
  void decrement() =>
      emit(state.count == 0 ? state : state.copyWith(count: state.count - 1));

  void setSize(ColthesSize size) => emit(state.copyWith(size: size));
}

enum ColthesSize { DEFAULT, S, M, L }

class Order {
  final int count;
  final ColthesSize size;

  Order({this.count = 0, this.size = ColthesSize.DEFAULT});

  Order copyWith({int? count, ColthesSize? size}) => Order(
        count: count ?? this.count,
        size: size ?? this.size,
      );
}
