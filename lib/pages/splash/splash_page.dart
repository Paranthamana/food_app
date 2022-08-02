import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
        vsync: this,duration:
        const Duration(seconds: 10))..forward();

    animation =  CurvedAnimation(
        parent: controller,
        curve: Curves.ease);

    Timer(
      const Duration(seconds: 5),
      ()=>Get.offNamed(RouteHelper.getSignInPage()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Center(child: Image.asset("assets/image/applogo.png", width: 250,)),
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/icon.png", width: Dimensions.spalshImg, height: 100,))),
          const SizedBox(height: 20,),
          Center(child: Text("Healthnable", style: TextStyle(color: AppColors.appPrimaryColor, fontSize: Dimensions.height45, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
