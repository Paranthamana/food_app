import 'package:foodapp/auth/signin_page.dart';
import 'package:foodapp/pages/address/add_address_page.dart';
import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/pages/foodData/popular_food_details.dart';
import 'package:foodapp/pages/foodData/recommended_food_details.dart';
import 'package:foodapp/pages/home/home_page.dart';
import 'package:foodapp/pages/splash/splash_page.dart';
import 'package:get/get.dart';
class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial ="/";
  static const String popularFood ="/popular-food";
  static const String recommendedFood ="/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-Address";

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>"$initial";
  static String getPopularFood(int pageId, String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId,String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=>"$cartPage";
  static String getSignInPage()=>"$signIn";
  static String getAddressPage()=>"$addAddress";

  static List<GetPage> routes =[
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage()),
    //GetPage(name: signIn, page: ()=>SignInPage(),transition: Transition.zoom),
    
    GetPage(name: signIn, page: (){
      return SignInPage();
    },transition: Transition.fade),

    GetPage(name: popularFood, page: (){
      var pageId =Get.parameters['pageId'];
      var page =Get.parameters['page'];
      print("popular food get called");
      return PopularFoodDetails(pageId: int.parse(pageId!), page:page!);
    },transition: Transition.fadeIn),

    GetPage(name: recommendedFood, page: (){
      print("popular food get called");
      var pageId =Get.parameters['pageId'];
      var page =Get.parameters['page'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!), page:page!);
    },transition: Transition.fadeIn),

    GetPage(name: cartPage, page: (){
      print("popular food get called");
      var pageId =Get.parameters['pageId'];
      return CartPage();
    },transition: Transition.fadeIn),
    
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    })
  ];
}