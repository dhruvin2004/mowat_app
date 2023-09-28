
import 'package:mowat_app/res/color_res.dart';
import 'package:mowat_app/screens/splash_screen/splash_view.dart';
import 'constants/app.export.dart';
import 'constants/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Injector.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryMaterialColor,
        scaffoldBackgroundColor: ColorRes.whiteColor,
        primaryColor: ColorRes.primaryColor,
        splashColor:  ColorRes.whiteColor,
        appBarTheme: AppBarTheme(
          // brightness: Brightness.dark,
          backgroundColor: ColorRes.whiteColor,
          iconTheme: IconThemeData(color: ColorRes.blackColor),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
