import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/order_cubit.dart';
import 'pages/login_page.dart'; // sudah benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderCubit()),
        // ...provider lain
      ],
      child: GotipApp(),
    );
  }
}