import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/auth_controller.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controller/cart_controller.dart';
import 'package:foodapp/controller/location_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/app_icon_custom.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print('user logged in');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", color: Colors.white, size: Dimensions.font26,),
        centerTitle: true,
      ),
      body: /*GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?*/Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [

              //--- profile icons
              AppIcon(icon: Icons.person,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height45+Dimensions.height30,
                  size: Dimensions.height15*10),

              SizedBox(height: Dimensions.height30),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //--- Name icon
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Bala" /*userController.userModel.name*/)),
                      SizedBox(height: Dimensions.height20),

                      //---mobile number
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "1234567890")),

                      SizedBox(height: Dimensions.height20),

                      //---email
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "abc@gmail.com")),

                      SizedBox(height: Dimensions.height20),

                      //---Address
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userLoggedIn&& locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(icon: Icons.location_on,
                                    backgroundColor: AppColors.appPrimaryColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10*5/2,
                                    size: Dimensions.height10*5),
                                bigText: BigText(text: "Enter your address")),
                          );
                        } else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(icon: Icons.location_on,
                                    backgroundColor: AppColors.appPrimaryColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10*5/2,
                                    size: Dimensions.height10*5),
                                bigText: BigText(text: "Your address")),
                          );
                        }
                      }),

                      SizedBox(height: Dimensions.height20),

                      //---Message
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.message,
                              backgroundColor: AppColors.appPrimaryColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Message")),


                      //---Logout
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: (){
                          print("tapped");
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          } else{
                            print("you not logged in auth not saved");
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(icon: Icons.logout,
                                backgroundColor: AppColors.appPrimaryColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                size: Dimensions.height10*5),
                            bigText: BigText(text: "Logout")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )/*:
        const CustomLoader()): const Center(child: Text("please Login and continue"),
        );
      }),*/
    );
  }
}
