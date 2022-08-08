import 'package:flutter/material.dart';
import 'package:foodapp/auth/auth_controller.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/controller/cart_controller.dart';
import 'package:foodapp/controller/location_controller.dart';
import 'package:foodapp/controller/popular_product_controller.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/constants.dart';
import 'package:foodapp/widgets/app_icon_custom.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controller/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   AppIcon(icon: Icons.arrow_back_ios,
                   iconColor: Colors.white,
                   backgroundColor: AppColors.mainColor,
                   iconSize: Dimensions.iconSize24),
                   SizedBox(width: Dimensions.width20*5),
                   GestureDetector(
                     onTap: (){
                       //Get.to(()=> MainFoodPage());
                       Get.offNamed(RouteHelper.getInitial());
                     },
                     child: AppIcon(icon: Icons.home_outlined,
                         iconColor: Colors.white,
                         backgroundColor: AppColors.mainColor,
                         iconSize: Dimensions.iconSize24),
                   ),
                   AppIcon(icon: Icons.shopping_cart_outlined,
                       iconColor: Colors.white,
                       backgroundColor: AppColors.mainColor,
                       iconSize: Dimensions.iconSize24)
                 ],
          )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*6,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder:(cartController){
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index){
                              return Container(
                                height: Dimensions.height20*6,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        var popularIndex = Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(_cartList[index].product!);
                                        if(popularIndex >=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                        } else{
                                          var recommendedIndex = Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(_cartList[index].product!);
                                          if(recommendedIndex<0){
                                            Get.snackbar("History product", "product review is not available for history products", backgroundColor: AppColors.mainColor, colorText: Colors.white);
                                          } else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20*5,
                                        height: Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL +cartController.getItems[index].img!),
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.height30*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text: cartController.getItems[index].name!, color: Colors.black54),
                                            SmallText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "\Rs."+ cartController.getItems[index].price.toString(), color: Colors.redAccent, size: Dimensions.font20),
                                                Container(
                                                  padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, top: Dimensions.width10, bottom: Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                      color: Colors.white
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: (){
                                                            //popularProduct.setQuantity(false);
                                                            cartController.addItems(_cartList[index].product!, -1);
                                                          },
                                                          child: Icon(Icons.remove, color: AppColors.signColor)),
                                                      SizedBox(width: Dimensions.width10/2),
                                                      BigText(text: _cartList[index].quantity.toString()/*popularProduct.inCartItems.toString()*/),
                                                      SizedBox(width: Dimensions.width10/2),
                                                      GestureDetector(
                                                          onTap: (){
                                                            // popularProduct.setQuantity(true);
                                                            cartController.addItems(_cartList[index].product!, 1);
                                                          },
                                                          child: Icon(Icons.add, color: AppColors.signColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),)
                                  ],
                                ),
                              );
                            });
                      })
                  ),
                )):NoDataPage(text: "Your cart is empty...!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2)),
          ),
          child: cartController.getItems.length>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text:"\Rs."+ cartController.totalAmount.toString()),
                    SizedBox(width: Dimensions.width10/2),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  //popularProduct.addItem(product);
                  if(Get.find<AuthController>().userLoggedIn()){
                    //cartController.addToHistory();
                    if(Get.find<LocationController>().addressList.isEmpty){
                        Get.toNamed(RouteHelper.getAddressPage());
                    }else{
                      Get.offNamed(RouteHelper.getInitial());
                    }
                  } else{
                    /* User not logged in we move to sign in page*/
                      //Get.toNamed(RouteHelper.getSignInPage());
                      Get.toNamed(RouteHelper.getAddressPage());
                  }
                  /*cartController.addToHistory();
                  print('tapped');*/

                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "Check out", color: Colors.white,),
                ),
              )
            ],
          ):Container(),
        );
      })
    );
  }
}
