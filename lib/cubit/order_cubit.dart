import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]); // Initialize with empty list

  // Add new order
  void addOrder(Order order) {
    emit([...state, order]);
  }

  // Get all orders
  List<Order> getOrders() => state;

  // Update order status
  void updateOrderStatus(Order order, String newStatus) {
    final updatedOrders = state.map((o) {
      if (o == order) {
        o.status = newStatus;
      }
      return o;
    }).toList();
    emit(updatedOrders);
  }

  // Delete order
  void deleteOrder(Order order) {
    final updatedOrders = state.where((o) => o != order).toList();
    emit(updatedOrders);
  }
}