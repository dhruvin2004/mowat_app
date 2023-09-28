import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mowat_app/screens/login/login_view.dart';

import '../../constants/app.export.dart';
import '../../res/image_res.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (_) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16),
              physics: BouncingScrollPhysics(),
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('carasoul_slider')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("${snapshot.error}");
                      return Text('Something went wrong ');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text("No data available");
                    }
                    return CarouselSlider(
                      items: [
                        ...List.generate(snapshot.data!.docs.length, (index) {
                          var data = snapshot.data!.docs[index];
                          return Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(data['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ],
                      options: CarouselOptions(
                        height: 220.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.95,
                      ),
                    );
                  },
                ),
                BaseText(
                  text: "New Trend",
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: Utils.getSize(10),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('watches')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print("${snapshot.error}");
                        return Utils.showToast("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return BaseText(text:  "No data Found");
                      }
                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                    children: [
                      ...List.generate(snapshot.data!.docs.length, (index) {
                        var data = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {},
                          child: AnimatedContainer(
                            padding: EdgeInsets.all(10),
                            duration: Duration(milliseconds: 600),
                            decoration: BoxDecoration(
                                color: ColorRes.whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorRes.blackColor.withOpacity(0.1),
                                    blurRadius: 16,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.network(data['image'],
                                    height: 140,
                                    width: Get.width,
                                  ),
                                ),
                                Spacer(),
                                BaseText(
                                  text: data['name'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                SizedBox(
                                  height: Utils.getSize(5),
                                ),
                                BaseText(
                                  text: "⭐ 4.5",
                                  color: ColorRes.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                SizedBox(
                                  height: Utils.getSize(5),
                                ),
                                BaseText(
                                  text: data['price'],
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),
                SizedBox(
                  height: Utils.getSize(100),
                ),
              ],
            ),
          );
        });
  }
}

// MaterialButton(onPressed: ()async{
// await FirebaseAuth.instance.signOut();
// Get.offAll(LoginView());
// await Injector.prefs!.remove(PrefKeys.userId);
// },child: BaseText(text: "Log Out"),),

//
// body: ListView(
// padding: EdgeInsets.all(Utils.getSize(22)),
// children: [

// ],
// ),
