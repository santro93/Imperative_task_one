import 'package:flutter/material.dart';
import 'package:imperative_task/screens/login/login_screen.dart';
import 'package:imperative_task/screens/transcation/transaction_list_screen.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/common_fun/local_auth_service.dart';
import 'package:imperative_task/utility/constants/app_colors.dart';
import 'package:imperative_task/utility/constants/app_constants.dart';
import 'package:imperative_task/utility/constants/widget_utils.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _startNavigationTimer();
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _startNavigationTimer() {
    _navigationTimer = Timer(const Duration(seconds: 1), _checkAuthAndNavigate);
  }

  void _navigateToBottomNavigationScreen() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TransactionListScreen(),
        ),
      );
    }
  }

  Future<void> _checkAuthAndNavigate() async {
    final savedToken =
        await SharedPreferencesService.getData(StorageKeys.accessToken);
    final isBiometricEnabled = await SharedPreferencesService.getBool(
            StorageKeys.isBiometricEnabled) ??
        false;
    if (!mounted) return;
    if (savedToken != null && savedToken.toString().isNotEmpty) {
      if (isBiometricEnabled) {
        final isAuthenticated = await BiometricService.authenticateUser();
        if (isAuthenticated) {
          _navigateToBottomNavigationScreen();
        } else {
          _navigateToLoginScreen();
        }
      } else {
        _navigateToBottomNavigationScreen();
      }
    } else {
      _navigateToLoginScreen();
    }
  }

  // Navigate to Login Screen
  void _navigateToLoginScreen() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceMedium,
            const Text(
              "Task One",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
