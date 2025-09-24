import 'package:flutter_bloc/flutter_bloc.dart';

// State
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String username, String password) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1)); // simulasi loading

    if (username == "admin" && password == "123") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure("Username atau password salah"));
    }
  }
}
