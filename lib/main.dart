import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pricetracker/util/strings.dart';
import 'package:pricetracker/viewmodel/gold_rate_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pricetracker/data/service/gold_rate_service.dart'; 
import 'view/splash_screen.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          final dio = Dio();
          final goldRateService = GoldRateService(dio);
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
      title: AppStrings.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber, 
        scaffoldBackgroundColor: const Color(0xFFF9F6F1), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F6F1), 
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black, 
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, 
          selectedItemColor: const Color(0xFFB88A44), 
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}