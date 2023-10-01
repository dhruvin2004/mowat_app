




import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../constants/app.export.dart';
import '../../constants/injector.dart';
import 'modal.dart';

class HomeController extends GetxController{





  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

  }
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  onSearchVal(val) {
    searchQuery = val;
    update();
  }


}