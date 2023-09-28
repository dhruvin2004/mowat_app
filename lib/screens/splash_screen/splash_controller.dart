import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:mowat_app/constants/injector.dart';
import 'package:mowat_app/screens/home_module/home_view.dart';

import '../bottom_module/bottom_bar_view.dart';
import '../login/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(Duration(seconds: 3), () {
      if (Injector.getUserId() != null) {
        Get.offAll(BottomNavigationBarCustom(),transition: Transition.cupertino);
      } else {
        Get.offAll(LoginView(),transition: Transition.cupertino);
      }
    });
  }
}
