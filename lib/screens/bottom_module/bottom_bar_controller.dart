


import 'package:get/get.dart';

import '../../constants/app.export.dart';
import '../../constants/pref_keys.dart';

class BottomNavigationBarTabController extends GetxController{

  int currentIndex = 0;
  String  currentPage = HomPageName.recipes;
  DateTime backTime = DateTime.now();

  List<String> bottomPageKey = [
    HomPageName.recipes,
    HomPageName.pantry,
    HomPageName.groceryList,
    HomPageName.providerProfile
  ];


  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    HomPageName.recipes: GlobalKey<NavigatorState>(),
    HomPageName.pantry: GlobalKey<NavigatorState>(),
    HomPageName.groceryList: GlobalKey<NavigatorState>(),
    HomPageName.providerProfile: GlobalKey<NavigatorState>(),
  };

  onSelectedIab(int index){
    currentPage = bottomPageKey[index];
    currentIndex  = index;
    update();
  }

  List appBarTitle = ["Discover","Favourite","My Cart","My Profile"];
}