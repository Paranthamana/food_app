import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, top: Dimensions.height30),
              child: Image.asset("assets/image/applogo.png"),
            ),BigText(text: "Login",size: Dimensions.font26,color: AppColors.appAccentColor),
            SizedBox(height: Dimensions.height45),
            AppTextField(textController: emailController, hintText: "user Name", icon: Icons.email),
            SizedBox(height: Dimensions.height20),
            AppTextField(textController: emailController, hintText: "password", icon: Icons.lock),
            RaisedButton(onPressed:(){},)

          ],
        ),
      ),
    );
  }
}
