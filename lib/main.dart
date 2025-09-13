import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/theme_provider.dart';
import 'providers/university_provider.dart';
import 'models/university.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/university_list_screen.dart';
import 'screens/university_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_panel_screen.dart';
import 'utils/theme.dart';
import 'services/notification_service.dart';
import 'services/deadline_reminder_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tbspmsavattbzcdjbhhi.supabase.co',
    anonKey: 'sb_publishable_ZIhKj_0i8_PMASlTpCamvA_Qp91IAb9',
  );

  // Initialize services with error handling
  try {
    await NotificationService().initialize();
    if (kDebugMode) {
      print('NotificationService initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('NotificationService initialization failed: $e');
    }
  }

  try {
    await DeadlineReminderService().initialize();
    if (kDebugMode) {
      print('DeadlineReminderService initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('DeadlineReminderService initialization failed: $e');
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UniversityProvider(),
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
        '/admin': (context) => const AdminLoginScreen(),
        '/admin-panel': (context) => const AdminPanelScreen(),
        '/university-detail': (context) {
          final university =
              ModalRoute.of(context)!.settings.arguments as University;
          return UniversityDetailScreen(university: university);
        },
      },
    );
  }
}
