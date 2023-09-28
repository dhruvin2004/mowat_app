




import 'package:get/get.dart';

import '../../constants/app.export.dart';
import '../../constants/injector.dart';

class HomeController extends GetxController{


  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
   // await FirebaseFetchData.fetchData().whenComplete(() => dataFetched.value = true);
    update();
  }

  TextEditingController search = TextEditingController();
  Rx<ValueNotifier> searchProduct = ValueNotifier<String>('').obs;
  RxInt pageIndex = 0.obs;
  RxBool dataFetched = false.obs;

  onBottomTap(val) {
    search.clear();
    searchProduct.value.value = '';
    pageIndex.value = val;
    update();
  }

  onSearchVal(val) {
    searchProduct.value.value = val;
    update();
  }


   List carousel = [
    "login_image.png",
    "login_image.png",
    "login_image.png",
    "login_image.png",
    "login_image.png",
  ];



 // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   print(Injector.getUserId());
  // }
}