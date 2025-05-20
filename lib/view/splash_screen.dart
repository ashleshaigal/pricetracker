import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/gold_rate_viewmodel.dart';
import 'dashboard_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {

    final goldRateViewModel = Provider.of<GoldRateViewModel>(
      context,
      listen: false,
    );


    await Future.wait([
      goldRateViewModel.fetchGoldRates(), 
      Future.delayed(const Duration(seconds: 2)),
    ]);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF003442), 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Image.asset(
              'assets/icon/splash.png', 
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFB88A44),
              ), 
            ),
          ],
        ),
      ),
    );
  }
}
