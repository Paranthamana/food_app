import 'package:flutter/material.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';

import 'package:get/get.dart';import 'package:get/get_core/src/get_main.dart';
import '../../controller/popular_product_controller.dart';


import '../../controller/recommended_product_controller.dart';
import '../../utils/colors.dart';
import 'food_Page_body.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);


  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Bangalore", color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: 'JAYA NAGER', color: Colors.black54,),
                        Icon(Icons.arrow_drop_down)
                      ],
                    )
                  ],
                ),
                Container(
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                )
              ],
            ),
          ),
        ),
        const Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ),
        onRefresh: _loadResources);
  }
}
