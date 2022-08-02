import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async{
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

 bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String name, String password) async{
    return await apiClient.postData(AppConstants.LOGIN_URI, {"userName":name,"password":password});
  }

  Future<bool> saveUserToken(String token)async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNameAndPassword(String name, String passowrd) async {
    try{
      await sharedPreferences.setString(AppConstants.NAME, name);
      await sharedPreferences.setString(AppConstants.PASSWORD, passowrd);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.NAME);
    apiClient.token="";
    apiClient.updateHeader("");
    return true;
  }

}