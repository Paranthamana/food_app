import 'package:foodapp/models/user_model.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/signup_response_model.dart';

class UserController extends GetxController implements GetxService {

  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel signUpResponseModel;

    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      signUpResponseModel = ResponseModel(true, "Successfully");
    } else {
      signUpResponseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }
    //_isLoading = false;
    update();
    return signUpResponseModel;
  }
}