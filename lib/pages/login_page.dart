import 'package:flutter/material.dart';
import 'order_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'customer_page.dart';
import 'income_page.dart';
import 'rating_page.dart';

void main() {
  runApp(const GotipApp());
}

class GotipApp extends StatefulWidget {
  const GotipApp({super.key});

  @override
  State<GotipApp> createState() => _GotipAppState();
}

class _GotipAppState extends State<GotipApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String? loggedInUser;

  // ignore: unused_element
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _login(String email) {
    setState(() {
      loggedInUser = email.split("@")[0]; // ambil nama dari email
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GOTIP Driver",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
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
          ? LoginPage(onLogin: _login)
          : HomePage(userName: loggedInUser!),
    );
  }
}

class LoginPage extends StatefulWidget {
  final Function(String) onLogin;
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400), // fix untuk web
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/gotip_rmv.png", // fix nama file
                        height: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "GOTIP Driver",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 103, 159, 254),
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
                          onPressed: () {
                            widget.onLogin(emailController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor:
                                const Color.fromARGB(255, 95, 170, 246),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18),
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Dibuat oleh: FarrasFadhilah",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
