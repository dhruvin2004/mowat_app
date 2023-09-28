import 'dart:ui';

import 'package:mowat_app/screens/profile_module/profile_controller.dart';

import '../../constants/app.export.dart';
import '../../res/Icon_res.dart';
import '../../res/Image_res.dart';
import '../../res/string_res.dart';
import '../admin/admin_module/watchlist_view.dart';
import 'modal.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        dispose: (_) => Get.delete<ProfileController>(),
        builder: (_) {
          return Scaffold(
            body: mainBody(_),
          );
        });
  }
}

mainBody(ProfileController _) {
  return SafeArea(
    child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(Injector.getUserId())
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

        List<ProfileModal> profiles = snapshot.data!.docs
            .map((doc) =>
                ProfileModal.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: ColorRes.primaryColor,
              backgroundImage: (profiles[0].userID.isEmpty)
                  ? NetworkImage(profiles[0].profileImage)
                  : null,
              child: Center(
                child: Icon(Icons.person, color: ColorRes.whiteColor, size: 50),
              ),
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: profiles[0].userID,
              fontWeight: FontWeight.w700,
              color: ColorRes.primaryColor,
              textAlign: TextAlign.center,
            ),
            BaseText(
              text: profiles[0].email,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            (_.user!.uid == StringRes.adminUID)
                ? getButton(
                    onTap: () {
                      Get.to(WatchListView(), transition: Transition.cupertino);
                    },
                    title: "Watch List",
                    icon: Icon(
                      Icons.watch,
                      color: ColorRes.primaryColor,
                    ))
                : Container(),
            SizedBox(
              height: Utils.getSize(10),
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getButton(
                onTap: () {
                  showDialogBox(() {
                    _.logOutButton();
                  });
                },
                title: "Log out",
                icon: Icon(
                  Icons.logout,
                  color: ColorRes.primaryColor,
                )),
          ],
        );
      },
    ),
  );
}

// getProfile(){
//   return ;
// }

getButton(
    {required Icon icon, required String title, required Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Utils.getSize(50),
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorRes.transparentColor,
      ),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: Utils.getSize(30),
          ),
          Expanded(
            child: BaseText(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorRes.textGreyColor,
            ),
          ),
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              color: ColorRes.textGreyColor.withOpacity(0.4),
            ),
          )
        ],
      ),
    ),
  );
}

showDialogBox(Function successCallback) {
  return Get.dialog(BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Utils.getSize(52), vertical: Utils.getSize(30)),
            decoration: BoxDecoration(
              color: ColorRes.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Utils.getSize(34)),
                Padding(
                  padding: EdgeInsets.only(
                      left: Utils.getSize(30), right: Utils.getSize(30)),
                  child: BaseText(
                    text: "Are you sure you want to log out of the App?",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorRes.blackColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Utils.getSize(26)),
                Padding(
                  padding: EdgeInsets.only(
                      right: Utils.getSize(16), left: Utils.getSize(16)),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Utils.getSize(14.5),
                                horizontal: Utils.getSize(16)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorRes.blackColor, width: 1),
                                color: ColorRes.whiteColor),
                            child: BaseText(
                              text: "Cancel",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: ColorRes.blackColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Utils.getSize(8)),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            successCallback();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Utils.getSize(14.5),
                                horizontal: Utils.getSize(16)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorRes.primaryColor, width: 1),
                                color: ColorRes.primaryColor),
                            child: BaseText(
                              text: "Yes",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: ColorRes.whiteColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Utils.getSize(16),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}
