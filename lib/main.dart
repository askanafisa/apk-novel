import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'main_page.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();
bool globalIsDarkMode = false;
Function(bool)? globalToggleTheme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() => isDarkMode = value);
    globalIsDarkMode = value;
  }

  @override
  void initState() {
    super.initState();
    _loadTheme();
    globalToggleTheme = toggleTheme;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('isDarkMode') ?? false;
    setState(() => isDarkMode = saved);
    globalIsDarkMode = saved;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dunia Fiksi',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messengerKey,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => MainPage(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
      },
    );
  }
}