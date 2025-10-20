import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart'; // <-- Import model yang sudah benar

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]);
  void addOrder(Order order) {
    // emit([...state, order]); // Cara lama
    final newState = List<Order>.from(state)..add(order); // Cara yang lebih aman
    emit(newState);
  }

  void acceptOrder(String orderId) {
    final updatedOrders = state.map((order) {
      if (order.id == orderId) {
        order.status = "diterima";
      }
      return order;
    }).toList();
    emit(updatedOrders);
  }

  void rejectOrder(String orderId) {
    final updatedOrders = state.where((order) => order.id != orderId).toList();
    emit(updatedOrders);
  }
}