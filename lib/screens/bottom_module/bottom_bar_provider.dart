
import '../../constants/app.export.dart';
import '../favourite_modul/favourite_view.dart';
import '../home_module/home_view.dart';
import '../mycart_module/mycart_view.dart';
import '../profile_module/profile_view.dart';


class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({required this.navigationKey,required this.tabItem});

  final GlobalKey<NavigatorState> navigationKey;
  final String tabItem;

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  @override
  Widget build(BuildContext context) {
    late Widget child;
    if(widget.tabItem == HomPageName.recipes){
      child = HomeView();
    }
    else if(widget.tabItem == HomPageName.pantry){
      child = FavouriteView();
    }
    else if(widget.tabItem == HomPageName.groceryList){
      child = MyCart();
    }
    else if(widget.tabItem == HomPageName.providerProfile){
      child = ProfileView();
    }
    return Navigator(
      key: widget.navigationKey,
      onGenerateRoute: (routeSetting){
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}