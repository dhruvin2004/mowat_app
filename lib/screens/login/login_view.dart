

import '../../constants/app.export.dart';


class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        dispose: (_) => Get.delete<LoginController>(),
        builder: (_) {
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

  mainBody(LoginController _) {
    return SafeArea(
      child: Container(
        color: ColorRes.whiteColor,
        child:  ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: Utils.getSize(130)),
            getHeaderImageView(_),
            SizedBox(height: Utils.getSize(30)),
            BaseText(
              text: "Welcome back",
              fontSize: 36,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Utils.getSize(20)),
            emailTextField(_),
            SizedBox(height: Utils.getSize(10)),
            passwordTextField(_),
            SizedBox(height: Utils.getSize(10)),
            forgotPasswordButton(_),
            SizedBox(height: Utils.getSize(35)),
            loginButton(_),
            SizedBox(height: Utils.getSize(35)),
            getSignUp(),
          ],
        ),
      ),
    );
  }

  getHeaderImageView(LoginController _) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utils.getSize(0)),
        child: Image.asset(
          Utils.getAssetsImg(ImageRes.appLogo),
          height: Utils.getSize(250),
          width: Utils.getSize(225),
        ),
      ),
    );
  }

  emailTextField(LoginController _) {
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

  passwordTextField(LoginController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        controller: _.passwordController,
        hintText: "Password",
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  forgotPasswordButton(LoginController _) {
    return GestureDetector(
      onTap: () {
       Get.to(ForgotView(),transition: Transition.cupertino);
      },
      child: Container(
        color: ColorRes.transparentColor,
        child: BaseText(
          text: "Forgot Password?",
        textAlign: TextAlign.center,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration.underline,
          fontFamily: "OpenSans",
        ),
      ),
    );
  }

  loginButton(LoginController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseRaisedButton(
        borderRadius: 16,
        buttonText: "Login",
        onPressed: () {
         _.checkValidation();
        },

      ),
    );
  }

  getSignUp() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        BaseText(
          text: "Don’t have an account?",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorRes.blackColor,
        ),
        GestureDetector(
            onTap: () {
              Get.to(() => SignUpView(),transition: Transition.cupertino);
            },
            child: BaseText(
                text: " Sign up here!",
                fontSize: 18,
                fontWeight: FontWeight.w800,
                textDecoration: TextDecoration.underline,
                color: ColorRes.primaryColor))
      ],
    );
  }

}
