/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/theme_provider.dart';
import 'utils/app_theme.dart';
import 'controllers/favorites_controller.dart';
import 'controllers/habit_controller.dart';
import 'controllers/announcement_controller.dart';
import 'controllers/reminder_controller.dart';
import 'controllers/prayer_controller.dart';
import 'services/fcm_service.dart';
import 'views/auth/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase — available on Android, iOS, Web, and Windows (configured)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Init FCM (mobile only — gracefully skips on desktop/web)
    await FcmService().init();
  } catch (_) {
    // Desktop platforms without Firebase config — continue without it
  }
  await FcmService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProvider(create: (_) => HabitController()),
        ChangeNotifierProvider(create: (_) => AnnouncementController()),
        ChangeNotifierProvider(create: (_) => ReminderController()),
        ChangeNotifierProvider(create: (_) => PrayerController()),
      ],
      child: const DhikrEaseApp(),
    ),
  );
}

class DhikrEaseApp extends StatelessWidget {
  const DhikrEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DhikrEase',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeProvider.themeMode,
      home: const SplashView(),
    );
  }
}*/




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Correct paths: these files are inside lib/screens/
import 'screens/hone_screen.dart';
import 'screens/habbit_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HabitProvider(),
      child: const DhikrEaseApp(),
    ),
  );
}

class DhikrEaseApp extends StatelessWidget {
  const DhikrEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DhikrEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
