


import 'package:mowat_app/screens/watch_details_module/watch_detail_controller.dart';

import '../../constants/app.export.dart';

class WatchDetailView extends StatelessWidget {
  const WatchDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WatchDetailController(),
        builder: (_){
      return Scaffold(
        appBar:  AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: ColorRes.transparentColor,
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        backgroundColor: ColorRes.transparentColor,
        centerTitle: true,
        title: BaseText(
          text: "Watch List",
          fontWeight: FontWeight.w600,
          fontSize: 26,
        ),
      ),

      );
    });
  }
}
