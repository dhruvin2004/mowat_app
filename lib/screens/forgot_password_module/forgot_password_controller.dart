import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../constants/utils.dart';
class ForgotPasswordController extends GetxController{

  TextEditingController emailController = TextEditingController();


  checkValidation(){
    if(emailController.text.trim().isEmpty)
      {
        Utils.showToast("Please Enter Email");
      }
    else if(Utils.validateEmail(emailController.text.trim()) != null)
      {
        Utils.showToast("Please Enter Valid Email");
      }
    else{
      //performForgotPassword();
    }
  }


  // performForgotPassword()
  // async{
  //   Map<String, dynamic> body = {
  //     "email": emailController.text.toLowerCase().trim(),
  //   };
  //   try {
  //     Utils.showCircularProgressLottie(true);
  //     CommonResponse? response = await DataSource.instance.forgotPasswordApi(body);
  //     Utils.showCircularProgressLottie(false);
  //     if (response != null && response.message != null) {
  //       Get.back();
  //       Utils.showSuccessToast(response.message);
  //     } else {
  //       debugPrint('Failed to login (in else): ${response?.errors.toString() ?? 'null'}');
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to login (in catch): $e');
  //   }
  // }

}