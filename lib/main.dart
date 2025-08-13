import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'models/university.dart';
import 'providers/university_provider.dart';
import 'providers/theme_provider.dart'; // Import ThemeProvider
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/university_list_screen.dart';
import 'screens/university_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UniversityProvider(prefs),
        ),
        ChangeNotifierProvider(
          // Add ThemeProvider
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const UniOptionApp(),
    ),
  );
}

class UniOptionApp extends StatelessWidget {
  const UniOptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume ThemeProvider to set the themeMode dynamically
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'UNI-OPTION',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode, // Use themeMode from provider
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/universities': (context) => const UniversityListScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/university-detail': (context) => const UniversityDetailScreen(),
      },
    );
  }
}
