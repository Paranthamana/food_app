import 'package:foodapp/data/repository/auth_repo.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/models/signup_response_model.dart';
import 'package:foodapp/utils/constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{

  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

 Future<SignUpResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late SignUpResponseModel signUpResponseModel;

    if(response.statusCode == 200){
        authRepo.saveUserToken(response.body["token"]);
        signUpResponseModel = SignUpResponseModel(true, response.body['token']);
    } else{
      signUpResponseModel = SignUpResponseModel(true, response.statusText!);
    }
    _isLoading =false;
    update();
    return signUpResponseModel;
  }

  Future<SignUpResponseModel> login(String name, String passowrd) async {
  //  print('getting token');
   // print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(name, passowrd);
    late SignUpResponseModel signUpResponseModel;

    if(response.statusCode == 200){
      //print('Backend token');
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
        signUpResponseModel = SignUpResponseModel(true, response.body['token']);
    } else{
      signUpResponseModel = SignUpResponseModel(false, response.statusText!);
    }
    _isLoading =false;
    update();
    return signUpResponseModel;
  }

  void saveUserNameAndPassword(String name, String passowrd)  {
    authRepo.saveUserNameAndPassword(name, passowrd);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
   return authRepo.clearSharedData();
  }
}