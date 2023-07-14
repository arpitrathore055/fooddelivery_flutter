import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/controllers/popular_product_controller.dart';
import 'package:fooddeliveryapp/controllers/recommended_product_controller.dart';
import 'package:fooddeliveryapp/routes/routehelper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..forward(); // first creating the instance first and then using the function forward then
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(
        RouterHelper.getInitial(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 236, 204, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/images.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Text(
              "The Best Food",
              style: TextStyle(
                fontSize: Dimensions.screenWidth / 10,
                color: AppColors.mainBlackColor,
                fontFamily: "cursive",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
