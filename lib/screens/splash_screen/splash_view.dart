



import '../../constants/app.export.dart';


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
