// lib/view/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/gold_rate_viewmodel.dart';
import 'dashboard_screen.dart'; // Import the new dashboard screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure _initializeData is called after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    // Access the GoldRateViewModel from the Provider
    // listen: false because we are just calling a method and not rebuilding based on changes here
    final goldRateViewModel = Provider.of<GoldRateViewModel>(
      context,
      listen: false,
    );

    // Call fetchGoldRates and wait for it to complete
    await Future.wait([
      goldRateViewModel.fetchGoldRates(), // Your data fetching operation
      Future.delayed(const Duration(seconds: 2)), // The 2-second delay
    ]);

    // Navigate to the DashboardScreen once data is fetched
    // Ensure the navigation happens after the build method might have completed
    // and after the current frame is rendered.
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF003442), // Or your app's primary background color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your app logo image
            // Ensure you have this asset defined in your pubspec.yaml
            Image.asset(
              'assets/icon/splash.png', // Example path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFB88A44),
              ), // Your gold color
            ),
          ],
        ),
      ),
    );
  }
}
