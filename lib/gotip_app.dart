 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotip_driver/cubit/order_cubit.dart';
import 'package:gotip_driver/pages/login_page.dart';
import 'package:gotip_driver/pages/order_page.dart';
import 'package:gotip_driver/pages/home_page.dart';
import 'package:gotip_driver/pages/profile_page.dart';
import 'package:gotip_driver/pages/customer_page.dart';
import 'package:gotip_driver/pages/income_page.dart';
import 'package:gotip_driver/pages/rating_page.dart';


class GotipApp extends StatefulWidget {
  const GotipApp({super.key});

  @override
  State<GotipApp> createState() => _GotipAppState();
}

class _GotipAppState extends State<GotipApp> {
  
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
 
  @override
  Widget build(BuildContext context) {
   
    return MultiBlocProvider(
      providers: [
        
        BlocProvider(
          create: (context) => OrderCubit(),
        ),

      ],
      

      child: MaterialApp(
        title: "GOTIP Driver",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
    
        routes: {
          '/order': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as String?;
            return OrderPage(
              userName: loggedInUser ?? "",
              initialService: args,
            );
          },
          '/profile': (context) => ProfilePage(userName: loggedInUser ?? ""),
          '/customers': (context) => const CustomerPage(), 
          '/income': (context) => const IncomePage(),
          '/rating': (context) => const RatingPage(),
        },
    
        home: loggedInUser == null
            ? AuthPage( 
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
