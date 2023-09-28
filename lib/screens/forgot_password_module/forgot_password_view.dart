


import '../../base_class/base_button.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';
import '../../res/image_res.dart';
import 'forgot_password_controller.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ForgotPasswordController(),
        dispose: (_)=> Get.delete<ForgotPasswordController>(),
        builder: (_){
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: mainBody(_),
          ),
        ),
      );
    });
  }


  mainBody(ForgotPasswordController _) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: Utils.getSize(100)),
              getHeaderImageView(_),
              SizedBox(height: Utils.getSize(30)),
              BaseText(
                text: "Forgot password?",
                fontSize: 36,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BaseText(
                  text: "Enter your email address and we’ll send you a link to reset your password.",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Utils.getSize(20)),
              emailTextField(_),
              SizedBox(height: Utils.getSize(35)),
              forgotButton(_),
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
    );
  }

  getHeaderImageView(ForgotPasswordController _) {
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

  emailTextField(ForgotPasswordController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseTextField(
        borderRadius: 16,
        controller: _.emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }


  forgotButton(ForgotPasswordController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BaseRaisedButton(
        borderRadius: 16,
        buttonText: "Send",
        onPressed: () {
          _.checkValidation();
        },

      ),
    );
  }
}
