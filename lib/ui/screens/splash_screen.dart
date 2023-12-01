import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_mp/ui/controllers/auth_controller.dart';
import 'package:task_mp/ui/screens/login_screen.dart';
import 'package:task_mp/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_mp/ui/widget/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  void gotoLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => isLoggedIn
                  ? const MainBottomNavScreen()
                  : const LoginScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 120,
          ),
        ),
      ),
    );
  }
}
