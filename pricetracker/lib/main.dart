import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pricetracker/data/service/gold_rate_service.dart'; // Ensure this path is correct
import 'view/splash_screen.dart'; // Import the new Splash Screen

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          final dio = Dio();
          final goldRateService = GoldRateService(dio);
          // ViewModel is created here, but data fetching is now handled in SplashScreen
          return GoldRateViewModel(goldRateService);
        }),
      ],
      child: const GoldTrackerApp(),
    ),
  );
}

class GoldTrackerApp extends StatelessWidget {
  const GoldTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Price Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber, // Primary color for the app
        scaffoldBackgroundColor: const Color(0xFFF9F6F1), // Default background for all scaffolds
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F6F1), // Match app bar background
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black, // Default icon/text color in app bar
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Background for the nav bar
          selectedItemColor: const Color(0xFFB88A44), // Amber-ish gold for selected
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
      // The initial screen is now the SplashScreen
      home: const SplashScreen(),
    );
  }
}