import 'package:foodapp/auth/auth_controller.dart';
import 'package:foodapp/controller/cart_controller.dart';
import 'package:foodapp/controller/popular_product_controller.dart';
import 'package:foodapp/data/repository/auth_repo.dart';
import 'package:foodapp/data/repository/cart_repo.dart';
import 'package:foodapp/data/repository/popular_product_repo.dart';
import 'package:foodapp/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async{

  final sharedPrefrences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPrefrences);
  //api clients
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL1));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  // repository
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}