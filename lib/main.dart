import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'screen/admin_screen.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/admin_provider.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: Consumer<AdminProvider>(
        builder: (context, adminProvider, _) {
          return MaterialApp(
            title: 'Sidatt Belkhair',
            debugShowCheckedModeBanner: false,
            theme: adminProvider.currentTheme.toThemeData(),
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: {
              '/': (context) => const MainApp(),
              '/admin': (context) => const AdminScreen(),
            },
            home: adminProvider.isAdminLoggedIn
                ? const AdminScreen()
                  : const MainApp(),
          );
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!).inMilliseconds < 300) {
      _tapCount++;
      if (_tapCount == 5) {
        context.read<AdminProvider>().loginAdmin('');
        Navigator.of(context).pushNamed('/admin');
        _tapCount = 0;
      }
    } else {
      _tapCount = 1;
    }
    _lastTapTime = now;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: const HomeScreen(),
    );
  }
}