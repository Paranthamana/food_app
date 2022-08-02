import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/auth_controller.dart';
import 'package:foodapp/auth/sign_up_page.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/base/show_custom_snackbar.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){

      String name = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("check your user name", title: "User name");
      } else if(password.isEmpty){
        showCustomSnackBar("check your password", title: "Password");
      } else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      } else{
        //Get.toNamed(RouteHelper.getInitial());
        authController.login(name, password).then((status){
          if(status.isSuccess){
            //showCustomSnackBar("Login Success.", title: "Great.!");
            Get.toNamed(RouteHelper.getInitial());
          } else{
            showCustomSnackBar(status.message);
          }
        });
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.07),
              //--App logo
              const SizedBox(
                //height: Dimensions.screenHeight*0.20,
                child: Center(
                  /*child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  backgroundImage: AssetImage("assets/image/applogo.png"),
                ),*/
                  child: Image( image: AssetImage("assets/image/applogo.png")),
                ),
              ),

              Container(
                //--welcome text
                margin: EdgeInsets.only(left: Dimensions.width30),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor
                      ),
                    ),
                    /* Text("sign into your account",
                          style: TextStyle(
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[500]),)*/
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30),
              //-- email field
              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20),

              //---password field
              AppTextField(textController: passwordController, hintText: "password", icon: Icons.password_sharp, isObscure: true,),
              SizedBox(height: Dimensions.height30),

              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                    text: TextSpan(
                      //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "forgot password?",
                        style: TextStyle(color: Colors.grey[500],fontSize: Dimensions.font26)
                    ),),
                  SizedBox(width: Dimensions.width30),
                ],
              ),

              SizedBox(height: Dimensions.height45),
              //--signIn button
              GestureDetector(
                onTap: (){
                  _login(authController);
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
                        text: "Sign In",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,)),
                ),
              ),

              SizedBox(height: Dimensions.height45),
              //--- Don't Have account text
              RichText(
                text: TextSpan(
                  //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Don't have an account?",
                    style: TextStyle(color: Colors.grey[500],fontSize: Dimensions.font26),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.downToUp),
                          text: " Create",
                          style: TextStyle(color: AppColors.mainBlackColor,fontSize: Dimensions.font26, fontWeight: FontWeight.bold))
                    ]
                ),
              ),


            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
