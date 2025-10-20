import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]); 

  void addOrder(Order order) {
    emit([...state, order]);
  }

  List<Order> getOrders() => state;

  void updateOrderStatus(Order order, String newStatus) {
    final updatedOrders = state.map((o) {
      if (o == order) {
        o.status = newStatus;
      }
      return o;
    }).toList();
    emit(updatedOrders);
  }

  void deleteOrder(Order order) {
    final updatedOrders = state.where((o) => o != order).toList();
    emit(updatedOrders);
  }

  void acceptOrder(String id) {}

  void rejectOrder(String id) {}
}