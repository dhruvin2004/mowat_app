
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:mowat_app/constants/app.export.dart';
import '../../constants/utils.dart';
import '../../res/string_res.dart';
import '../bottom_module/bottom_bar_view.dart';
import '../home_module/home_view.dart';
import 'model.dart';

class LoginController extends GetxController {

 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();


  checkValidation(){
    if(emailController.text.trim().isEmpty)
      {
        Utils.showToast("Please Enter Email");
      }
    else  if(passwordController.text.trim().isEmpty)
    {
      Utils.showToast("Please Enter password");
    }
    else if(Utils.validateEmail(emailController.text.trim()) != null )
      {
        Utils.showToast("Please Enter Valid Email");
      }
    else if(passwordController.text.trim().length < 8)
      {
        Utils.showToast("Please Enter Valid password");
      }
    else{
      performLogin();
    }
  }

   performLogin()async{
     try {
       Utils.showCircularProgressLottie(true);
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController.text.trim(),
         password: passwordController.text.trim(),
       );
       Utils.showCircularProgressLottie(false);
       final user = credential.user;
       if (user != null) {
         Utils.showToast("Login Sucsesfully");
         Injector.setUserId(user.uid);
             Get.offAll(BottomNavigationBarCustom(),transition: Transition.cupertino);
       } else {
        Utils.showToast("Wrong password provided for that user.");
       }

     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         Utils.showToast("No user found for that email");
       } else if (e.code == 'wrong-password') {
         Utils.showToast("Wrong password provided for that user.");
       }
       else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
         Utils.showToast('Please check your email and password.');
       }
     }


  }

 // void performLogin() async {
 //   Utils.showCircularProgressLottie(true);
 //   CommonResponse? commonResponse = await DataSource.instance.loginApi(
 //     {
 //       "email": emailController.text.trim(),
 //       "password": passwordController.text.trim(),
 //     },
 //   );
 //   Utils.showCircularProgressLottie(false);
 //   try{
 //     if (commonResponse != null && commonResponse.data != null) {
 //       UserModal userModel = UserModal.fromJson(commonResponse.data);
 //       Injector.setUserData(userModel);
 //       Injector.setAccessToken(userModel.auth!.accessToken!);
 //       String? token = Injector.prefs!.getString(PrefKeys.accessToken);
 //       if (token != null && token.isNotEmpty) {
 //         Get.offAll(HomeView());
 //       } else {
 //         Utils.showErrToast("SOMETHING WENT WRONG!");
 //       }
 //     } else {
 //       if (commonResponse != null &&
 //           commonResponse.message != null &&
 //           commonResponse.message!.isNotEmpty) {
 //       }
 //     }
 //   }catch(e){
 //     debugPrint("Error : $e");
 //   }
 // }
}
