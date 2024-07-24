import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/core/res/app_assets.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    moveToMainApp();
    super.initState();
  }

  moveToMainApp() async {
    await Future.delayed(const Duration(seconds: 2));
    context.go('/app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    AppAssets.iconLogo,
                    width: 120,
                    height: 120,
                  )),
              const Text('Elemes MovieDB', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
