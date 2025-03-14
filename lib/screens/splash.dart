import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/widgets/loading_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _authController.initAuthState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // Wrap avec Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ), */
            const SizedBox(height: 70),
            LoadingCircularProgress()
          ],
        ),
      ),
    );
  }
}
