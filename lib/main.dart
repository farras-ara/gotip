import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotip_driver/cubit/order_state.dart';
import 'pages/login_page.dart'; // Mengimpor GotipApp dari login_page.dart

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderCubit()),
      
      ],
      child: GotipApp(),
    )
  );
}