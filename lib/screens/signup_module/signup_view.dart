

import 'package:mowat_app/screens/signup_module/signup_controller.dart';

import '../../base_class/base_button.dart';
import '../../base_class/base_text.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';
import '../../constants/utils.dart';
import '../../res/color_res.dart';
import '../../res/image_res.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignUpController(),
        dispose: (_) => Get.delete<SignUpController>(),
        builder: (_){
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: mainBody(_),
        ),
      );
    });
  }



  mainBody(SignUpController _) {
    return SafeArea(
      child: Container(
        color: ColorRes.whiteColor,
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: Utils.getSize(40)),
                getHeaderImageView(_),

                BaseText(
                  text: "Welcome to Mowat",
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                BaseText(
                  text: "your personal assistant",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Utils.getSize(24)),
                userTextField(_),
                SizedBox(height: Utils.getSize(10)),
                emailTextField(_),
                SizedBox(height: Utils.getSize(10)),
                passwordTextField(_),
                SizedBox(height: Utils.getSize(10)),
                confirmPasswordTextField(_),
                SizedBox(height: Utils.getSize(35)),
                signUpButton(_),
                SizedBox(height: Utils.getSize(35)),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.only(left: Utils.getSize(10), top: 10),
                color: ColorRes.transparentColor,
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getHeaderImageView(SignUpController _) {
    return Center(
      child: Image.asset(
        Utils.getAssetsImg(ImageRes.appLogo),
        height: Utils.getSize(250),
        width: Utils.getSize(225),
      ),
    );
  }


  userTextField(SignUpController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
        controller: _.userNameController,
        hintText: "User Name",
        textInputType: TextInputType.emailAddress,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }


  emailTextField(SignUpController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
        controller: _.emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }




  passwordTextField(SignUpController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
      
        textInputType: TextInputType.text,
        controller: _.passwordController,
        hintText: "Password",
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  confirmPasswordTextField(SignUpController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        controller: _.confirmPassController,
        hintText: "Confirm Password",
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }



  signUpButton(SignUpController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseRaisedButton(
        borderRadius: 16,
        buttonText: "Sign Up",
        onPressed: () {
          _.checkValidation();
        },
      ),
    );
  }
}
