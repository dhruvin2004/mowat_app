import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../base_class/base_text.dart';
import '../../constants/app.export.dart';
import '../../constants/utils.dart';
import '../../res/color_res.dart';
import 'mycart_controller.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MyCartController(),
        builder: (_) {
      return Stack(
        children: [

          ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(Injector.getUserId()).snapshots(),
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
                    return   ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs[0]['myCart'].length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[0]['myCart'][index];
                        return Slidable(
                          key:  ValueKey(0),
                          endActionPane:  ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                label: 'Delete',
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                onPressed: (context) {},
                              ),
                            ],
                          ),
                          child:GestureDetector(
                            onTap: (){
                              Get.to(WatchDetailView(isTrue: false,), transition: Transition.cupertino, arguments: [data]);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorRes.blackColor.withOpacity(0.1),

                                      blurRadius: 16,
                                    ),
                                  ]
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.network(data['image'],
                                        height: 100,
                                        width: 100,

                                      ),
                                    ),
                                    SizedBox(width: Utils.getSize(20),),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BaseText(text:data['name'],fontWeight: FontWeight.w600,fontSize: 18,),
                                          SizedBox(height: Utils.getSize(5),),
                                          BaseText(text: "⭐ 4.5",color: ColorRes.primaryColor,fontWeight: FontWeight.w600,fontSize: 16,),
                                          SizedBox(height: Utils.getSize(5),),
                                          Row(
                                            children: [
                                              BaseText(text: data['price'],fontWeight: FontWeight.w600,),

                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                              ,
                            ),
                          ),


                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    );
                  }),

              SizedBox(
                height: Utils.getSize(100),
              ),
            ],
          ),
          Column(
            children: [
              Spacer(),
              Container(
                height: 300,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.whiteColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40),),
                    boxShadow: [
                      BoxShadow(
                        color: ColorRes.blackColor.withOpacity(0.1),
                        offset: Offset(0,-10),
                        blurRadius: 16,
                      ),
                    ]
                ),
              ),
              SizedBox(height: Utils.getSize(80),),
            ],
          ),
        ],
      );
    });
  }
}
