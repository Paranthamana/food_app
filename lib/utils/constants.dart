class AppConstants{
  static const String APP_NAME = "Ontabee";
  static const int APP_VERSION = 1;


  static const String BASE_URL ="http://mvs.bslmeiyu.com";
  //static const String BASE_URL ="http://103.177.225.48/";
  static const String BASE_URL1 ="http://103.177.225.48/";


  static const String POPULAR_PRODUCT_URI ="/api/v1/products/popular";
  //static const String LOGIN_URI =/*BASE_URL1+*/"assets_api/api/v0/Authenticate";
  static const String RECOMMENDED_PRODUCT_URI ="/api/v1/products/recommended";

  //---user and auth end points
  static const String REGISTRATION_URI ="/api/v1/auth/register";
  static const String LOGIN_URI ="/api/v1/auth/login";
  static const String USER_INFO_URI ="/api/v1/customer/info";

  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "api/v1/customer/address/list";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";

  static const String TOKEN = "";
  static const String NAME = "";
  static const String PASSWORD = "";

  static const String UPLOAD_URL = "/uploads/";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

}