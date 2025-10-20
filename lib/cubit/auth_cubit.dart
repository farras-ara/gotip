import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthNewOrderNotification extends AuthState {
  final Map<String, dynamic> data;
  AuthNewOrderNotification(this.data);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    
    initializeFirebaseMessaging();
  }

  void initializeFirebaseMessaging() async {
   
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications.');
    }

    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token Driver: $token");
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Pesanan Baru Diterima saat App Foreground!');
      print('Data Pesanan: ${message.data}');
      
      emit(AuthNewOrderNotification(message.data));
    });

  }

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