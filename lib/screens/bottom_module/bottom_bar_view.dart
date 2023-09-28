
import 'package:mowat_app/base_class/base_bottomBar.dart';

import '../../constants/app.export.dart';

import '../../res/icon_res.dart';
import 'bottom_bar_controller.dart';
import 'bottom_bar_provider.dart';



class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavigationBarTabController(),
        dispose: (_) => Get.delete<BottomNavigationBarTabController>(),
        builder: (_){
          return WillPopScope(
            onWillPop: ()async{
              final isFirstTab =
              !await _.navigatorKeys[_.currentPage]!.currentState!.maybePop();
              print(isFirstTab);
              if (isFirstTab) {
                DateTime now = DateTime.now();
                if (now.difference(_.backTime) >
                    Duration(seconds: 2)) {
                  _.backTime = now;
                  return Future.value(false);
                }
                return Future.value(true);

              }
              return isFirstTab;
            },
            child: GestureDetector(
              onTap: ()=>Utils.hideKeyboard(context),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ColorRes.transparentColor,
                  centerTitle: true,
                  title: BaseText(text: _.appBarTitle[_.currentIndex],fontWeight: FontWeight.w600,fontSize: 26,),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    bottomBarScreen(_.currentPage,_),
                    bottomBar(_),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}


Widget bottomBar(BottomNavigationBarTabController _){
  return BottomNavigationTabBarItem(iconSize: 30,
    customContainerHeight: 80,
    onSelectItem: (index){
      _.onSelectedIab(index);
    },
    backgroundColor: ColorRes.whiteColor,
    selectedIndex: _.currentIndex,
    items: <BottomNavyBarItem>[
      BottomNavyBarItem(
        icon: Image.asset(Utils.getAssetsIcon(IconRes.home),color: ColorRes.textGreyColor.withOpacity(0.7),height:Utils.getSize(30) ,),
        selectedIcon: Image.asset(Utils.getAssetsIcon(IconRes.home),color: ColorRes.primaryColor,height:Utils.getSize(30) ,),
        title: "Home",
      ),
      BottomNavyBarItem(
        icon: Image.asset(Utils.getAssetsIcon(IconRes.like),color: ColorRes.textGreyColor.withOpacity(0.7),height:Utils.getSize(30) ,),
        selectedIcon: Image.asset(Utils.getAssetsIcon(IconRes.like),color: ColorRes.primaryColor,height:Utils.getSize(30) ,),
        title: "Favourite",
      ),
      BottomNavyBarItem(
        icon: Image.asset(Utils.getAssetsIcon(IconRes.cart),color: ColorRes.textGreyColor.withOpacity(0.7),height:Utils.getSize(30) ,),
        selectedIcon: Image.asset(Utils.getAssetsIcon(IconRes.cart),color: ColorRes.primaryColor,height:Utils.getSize(30) ,),
        title: "My Cart",
      ),
      BottomNavyBarItem(
        icon: Image.asset(Utils.getAssetsIcon(IconRes.profile),color: ColorRes.textGreyColor.withOpacity(0.7),height:Utils.getSize(30) ,),
        selectedIcon: Image.asset(Utils.getAssetsIcon(IconRes.profile),color: ColorRes.primaryColor,height:Utils.getSize(30) ,),
        title: "Profile",
      ),
    ],
  );
}



Widget bottomBarScreen(String tabItem , BottomNavigationBarTabController _ ){
  return Offstage(
    offstage: _.currentPage != tabItem,
    child: BottomNavigationBarPage(
      navigationKey: _.navigatorKeys[tabItem]??GlobalKey(),
      tabItem : tabItem,
    ),
  );
}


