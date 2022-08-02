import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/auth_controller.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/base/show_custom_snackbar.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var mobileController = TextEditingController();
    var signUpImages = ["t.png","f.png","g.png"];

    void _registration(AuthController authController){
      //var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String mobile = mobileController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("check your user name", title: "Name");
      }else if(mobile.isEmpty){
        showCustomSnackBar("check your mobile number", title: "Mobile number");
      }else if(email.isEmpty){
        showCustomSnackBar("check your email id", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid Email");
      }else if(password.isEmpty){
        showCustomSnackBar("check your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("check your password length", title: "Password");
      }else{
        //showCustomSnackBar("Login Success", title: "Good..!");
        SignUpBody signUpBody = SignUpBody(name: name, mobile: mobile, email: email, password: password);
        //print(signUpBody.toString());
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            //print("Success registration");
            showCustomSnackBar(status.message);
          } else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.02),
          //--App logo
          SizedBox(
            height: Dimensions.screenHeight*0.20,
            child: const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                backgroundImage: AssetImage("assets/image/icon.png"),
              ),
            ),
          ),

          Expanded(
              child: GetBuilder<AuthController>(builder: (_authContoller){
                  return !_authContoller.isLoading?SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //-- email field
                        AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
                        SizedBox(height: Dimensions.height20),

                        //---password field
                        AppTextField(textController: passwordController, hintText: "password", icon: Icons.password_sharp, isObscure: true),
                        SizedBox(height: Dimensions.height20),

                        //---user name field
                        AppTextField(textController: nameController, hintText: "Name", icon: Icons.person),
                        SizedBox(height: Dimensions.height20),

                        //---mobile number field
                        AppTextField(textController: mobileController, hintText: "Mobile", icon: Icons.phone),
                        SizedBox(height: Dimensions.height20),

                        //--signUp button
                        GestureDetector(
                          onTap: (){
                            _registration(_authContoller);
                          },
                          child: Container(
                            width: Dimensions.screenWidth/2,
                            height: Dimensions.screenHeight/13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainColor
                            ),
                            child: Center(
                                child: BigText(
                                  text: "Sign up",
                                  size: Dimensions.font20+Dimensions.font20/2,
                                  color: Colors.white,)),
                          ),
                        ),

                        //--- Have an account
                        SizedBox(height: Dimensions.height20),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                                text: "Have an account already?",
                                style: TextStyle(color: Colors.grey[500],fontSize: Dimensions.font26)
                            )),

                        //--- sign up options
                        SizedBox(height: Dimensions.screenHeight*0.05),
                        RichText(
                          text: TextSpan(
                            //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                              text: "Sign up using one of the following methods?",
                              style: TextStyle(color: Colors.grey[500],fontSize: Dimensions.font16)
                          ),
                        ),
                        Wrap(
                          children: List.generate(3, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage("assets/image/"+signUpImages[index]),
                            ),
                          )),
                        )
                      ],
                    ),
                  ):const CustomLoader();
              })
      ),
    ]));
  }
}
