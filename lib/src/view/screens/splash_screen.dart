import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/core/assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        Future.delayed(const Duration(milliseconds: 500)).then(
          (value) => Navigator.pushReplacementNamed(context, AppRouter.rMovies),
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.imgBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: Tween(begin: 0.0, end: 5.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.bounceOut,
              ),
            ),
            child: const Text(
              "Movies App",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
