import 'dart:ui';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mowat_app/screens/admin/admin_module/watchlist_controller.dart';

import '../../../constants/app.export.dart';
import '../add_update_module/add_update_view.dart';

class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WatchListController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
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
            body: mainBody(_),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: GestureDetector(
              onTap: () {
                Get.to(AddUpdateView(),
                    arguments: ["", false], transition: Transition.cupertino);
              },
              child: AnimatedContainer(
                height: 50,
                width: 150,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorRes.primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                duration: Duration(milliseconds: 600),
                child: BaseText(
                  text: "+ Add Watch",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        });
  }

  mainBody(WatchListController _) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('watches').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return Utils.showToast("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return BaseText(text: "No data Found");
          }
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ListView.separated(
                padding: EdgeInsets.all(16),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {},
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(bottom: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: data['image'] == ""
                                  ? Container()
                                  : Image.network(
                                      data['image'],
                                      height: 100,
                                      width: 100,
                                    ),
                            ),
                            SizedBox(
                              width: Utils.getSize(20),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  Row(
                                    children: [
                                      BaseText(
                                        text: data['price'],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Utils.getSize(5),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(AddUpdateView(),
                                              arguments: [
                                                data.id,
                                                true,
                                                data['name'],
                                                data['price'],
                                                data['image'],
                                                _.profileImage,
                                              ],
                                              transition: Transition.cupertino);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: BaseText(
                                            text: "Update",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: ColorRes.whiteColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Utils.getSize(10),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDeleteDialogBox(() {
                                            _.deleteWatch(data.id);
                                            Get.back();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: ColorRes.redColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: BaseText(
                                            text: "Delete",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: ColorRes.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
              SizedBox(
                height: Utils.getSize(100),
              ),
            ],
          );
        });
  }

  showDeleteDialogBox(Function successCallback) {
    return Get.dialog(
        barrierDismissible: false,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Utils.getSize(52),
                      vertical: Utils.getSize(30)),
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
                          text: "Are you sure you want to Delete?",
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
                                          color: ColorRes.primaryColor,
                                          width: 1),
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
                      SizedBox(height: Utils.getSize(16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
