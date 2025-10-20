import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:gotip_driver/cubit/order_cubit.dart';
import 'package:gotip_driver/pages/login_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/order_page.dart'; 

import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/customer_page.dart';
import 'pages/income_page.dart';
import 'pages/rating_page.dart';

class _GotipAppState extends State<GotipApp> {
  ThemeMode? _themeMode;
  
  var _login;
  
  get loggedInUser => null;

  @override
  Widget build(BuildContext context) {
    VoidCallback? _logout;
    var login = _login;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
      ],
      child: MaterialApp( 
        title: "GOTIP Driver",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF679FFE)),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        builder: (context, widget) => ResponsiveBreakpoints.builder(
          child: ClampingScrollWrapper.builder(context, widget!),
          breakpoints: [
            const Breakpoint(start: 0, end: 480, name: MOBILE),
            const Breakpoint(start: 481, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
          ],
        ),
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
            ? LoginPage(onLogin: login)
            : HomePage(userName: loggedInUser!, onLogout: _logout),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final Function(String) onLogin;
  LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<bool> _checkLogin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return email.isNotEmpty && password == "1234"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/gotip_rmv.png", height: 100),
                    const SizedBox(height: 16),
                    Text(
                      "GOTIP Driver",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF679FFE),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() => _isLoading = true);
                                final ok = await _checkLogin(
                                  emailController.text,
                                  passwordController.text,
                                );
                                setState(() => _isLoading = false);
                                if (ok) {
                                  widget.onLogin(emailController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Email atau password salah!"),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF5FAAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Login",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Dibuat oleh: Farras Fadhilah",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
