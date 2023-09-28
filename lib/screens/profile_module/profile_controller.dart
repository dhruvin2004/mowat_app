


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


import '../../constants/injector.dart';
import '../../constants/pref_keys.dart';
import '../login/login_view.dart';
import '../login/model.dart';

class ProfileController extends GetxController{

  UserModal? userModel;


  final user = FirebaseAuth.instance.currentUser;

  //
  // getProfile() async {
  //   try {
  //     CommonResponse? commonResponse = await DataSource.instance.getProfileApi();
  //     if (commonResponse != null && commonResponse.data != null) {
  //        userModel = UserModal.fromJson(commonResponse.data);
  //        update();
  //     }
  //   } catch (err) {
  //     Utils.showErrToast("SOMETHING WENT WRONG!");
  //   }
  // }
  //

  void logOutButton(){
    Injector.prefs!.remove(PrefKeys.userId);
    Get.offAll(LoginView());
    update();
  }




  @override
  void onInit() {
    // TODO: implement onInit
    // getProfile();
    super.onInit();
  }


}