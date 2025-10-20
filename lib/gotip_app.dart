// gotip_app.dart (VERSI PERBAIKAN LENGKAP)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotip_driver/cubit/order_cubit.dart';
import 'package:gotip_driver/pages/login_page.dart'; // Impor AuthPage dari login_page.dart

// Impor semua halaman Anda
import 'package:gotip_driver/pages/order_page.dart';
import 'package:gotip_driver/pages/home_page.dart';
import 'package:gotip_driver/pages/profile_page.dart';
import 'package:gotip_driver/pages/customer_page.dart';
import 'package:gotip_driver/pages/income_page.dart';
import 'package:gotip_driver/pages/rating_page.dart';

// 1. Ini adalah kelas Widget utama aplikasi Anda
class GotipApp extends StatefulWidget {
  const GotipApp({super.key});

  @override
  State<GotipApp> createState() => _GotipAppState();
}

class _GotipAppState extends State<GotipApp> {
  // 2. Logika state login dipindahkan ke sini (dari login_page.dart)
  String? loggedInUser;
  final Map<String, String> _accounts = {};

  void _login(String email) {
    setState(() {
      loggedInUser = email.split("@")[0]; 
    });
  }

  void _logout() {
    setState(() {
      loggedInUser = null;
    });
  }

  void _register(String email, String password) {
    setState(() {
      _accounts[email] = password;
    });
  }
  // Selesai memindahkan logika login

  @override
  Widget build(BuildContext context) {
    // 3. MultiBlocProvider diletakkan di sini, di level tertinggi
    return MultiBlocProvider(
      providers: [
        // Di sinilah OrderCubit dibuat.
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        // (Anda bisa tambahkan Cubit/Bloc lain di sini)
      ],
      
      // 4. MaterialApp sekarang menjadi 'child' dari provider
      child: MaterialApp(
        title: "GOTIP Driver",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        
        // 5. Semua Rute sekarang bisa "melihat" OrderCubit
        routes: {
          '/order': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as String?;
            return OrderPage(
              userName: loggedInUser ?? "",
              initialService: args,
            );
          },
          '/profile': (context) => ProfilePage(userName: loggedInUser ?? ""),
          '/customers': (context) => const CustomerPage(), // <-- INI SEKARANG AKAN BERHASIL
          '/income': (context) => const IncomePage(),
          '/rating': (context) => const RatingPage(),
        },
        
        // 6. Logika 'home' (halaman awal) tetap sama
        home: loggedInUser == null
            ? AuthPage( // Gunakan AuthPage dari login_page.dart
                onLogin: _login,
                onRegister: _register,
                accounts: _accounts,
              )
            : HomePage(
                userName: loggedInUser!,
                onLogout: _logout,
              ),
      ),
    );
  }
}
