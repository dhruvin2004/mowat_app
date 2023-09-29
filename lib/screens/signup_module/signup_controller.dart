


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mowat_app/screens/home_module/home_view.dart';
import '../../constants/injector.dart';
import '../../constants/pref_keys.dart';
import '../../constants/utils.dart';
import '../bottom_module/bottom_bar_view.dart';
import '../login/model.dart';

class SignUpController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController= TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isUserIdValid(String userId) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!regex.hasMatch(userId)) {
      return false;
    }
    return true;
  }

  checkValidation(){
    if(userNameController.text.trim().isEmpty)
    {
      Utils.showToast("Please Enter user Name");
    }
     else if(emailController.text.trim().isEmpty)
    {
      Utils.showToast("Please Enter Email");
    }
    else  if(passwordController.text.trim().isEmpty)
    {
      Utils.showToast("Please Enter password");
    }
    else if(confirmPassController.text.trim().isEmpty)
      {
        Utils.showToast("Please Enter confirm password");
      }
    else if(Utils.validateEmail(emailController.text.trim()) != null )
    {
      Utils.showToast("Please Enter Valid Email");
    }
    else if(passwordController.text.trim().length < 8)
    {
      Utils.showToast("Please Enter Valid password");
    }
    else if(confirmPassController.text.trim().length < 8)
    {
      Utils.showToast("Please Enter Valid confirm password");
    }
    else if(passwordController.text.trim() != confirmPassController.text.trim())
      {
        Utils.showToast("The password and confirm password does not match");
      }
    else{
     performRegister();
    }
  }

void performRegister()async{
  try {
    Utils.showCircularProgressLottie(true);
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Utils.showCircularProgressLottie(false);

    final user = credential.user;
    if (user != null) {
      await user?.updateDisplayName(userNameController.text.trim());
      Utils.showToast('User successfully created.');
      Injector.setUserId(user.uid);
      addUser(user.uid);
      Get.offAll(BottomNavigationBarCustom(),transition: Transition.cupertino);
    } else {
      Utils.showToast('User is null. Something went wrong.');
    }

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Utils.showToast('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      Utils.showToast('The account already exists for that email.');
    } else {
      print('An error occurred: ${e.code}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }

}


  Future<void> addUser(String uid) {
    return FirebaseFirestore.instance.collection(uid)
        .add({
      'userId': userNameController.text.trim(),
      'email' : emailController.text.trim(),
      'password' : passwordController.text.trim(),
      'myCart' : [],
      'myFav' : [],
      'profileImage' : '',
    })
        .then((value) => print("User Added"),)
        .catchError((error) => print("Failed to add user: $error"));
  }

}