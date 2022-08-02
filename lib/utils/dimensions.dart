import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Dimensions{

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView =screenHeight/2.64;
  static double pageViewController =screenHeight/3.84;
  static double pageViewTextContainer =screenHeight/7.03;

  // font size
  static double font20 =screenHeight/42.2;
  static double font26 =screenHeight/32.46;
  static double font16 =screenHeight/52.75;

  //Dynamic height padding and margin
  static double height10 =screenHeight/84.4;
  static double height5 =screenHeight/54.4;
  static double height15 =screenHeight/56.27;
  static double height20 =screenHeight/42.2;
  static double height30 =screenHeight/28.13;
  static double height45 =screenHeight/18.76;

  //Dynamic width padding and margin
  static double width10 =screenHeight/84.4;
  static double width5 =screenHeight/54.4;
  static double width15 =screenHeight/56.27;
  static double width20 =screenHeight/42.2;
  static double width30 =screenHeight/28.13;

  //Dynamic radius
  static double radius15 =screenHeight/56.27;
  static double radius20 =screenHeight/42.2;
  static double radius30 =screenHeight/28.13;

  //icon size
  static double iconSize24 =screenHeight/35.17;
  static double iconSize16 =screenHeight/52.75;

  //Listview size iphome screen with is 390
 static double listViewImgSize = screenWidth/3.25;
 static double listViewTextContSize = screenWidth/3.9;

 // food
  static double popularFoodImgSize = screenHeight/2.41;

  //bottom height
  static double bottomHeightBar = screenHeight/7.03;

  //splash screen dimensions
  static double spalshImg = screenHeight/3.38;
}