import 'package:flutter/material.dart';
import 'package:foodapp/auth/signin_page.dart';
import 'package:foodapp/controller/cart_controller.dart';
import 'package:foodapp/controller/popular_product_controller.dart';
import 'package:foodapp/controller/recommended_product_controller.dart';
import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/splash/splash_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';

import 'auth/sign_up_page.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OnTabee',
          //home: SignInPage(),
          //home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
