



import 'package:mowat_app/screens/splash_screen/splash_controller.dart';
import '../../constants/app.export.dart';
import '../../constants/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        dispose: (_)=>Get.delete<SplashController>(),
        builder: (_){
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Utils.getLogoImage(context),
          ),
        ),
      );
    });
  }
}
