



import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants/app.export.dart';
import '../../res/image_res.dart';
import 'favourite_controller.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FavouriteController(),
        builder: (_){
      return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          ...List.generate(20, (index) {

            return
              GestureDetector(
                onTap: (){

                },
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
                      ]
                  ),
                  child: Slidable(
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
                    child:

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network("https://i.insider.com/550c3ba8ecad04cf608b4567?width=715&format=jpeg",
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

                                BaseText(text: "Watch Name",fontWeight: FontWeight.w600,fontSize: 18,),
                                SizedBox(height: Utils.getSize(5),),
                                BaseText(text: "⭐ 4.5",color: ColorRes.primaryColor,fontWeight: FontWeight.w600,fontSize: 16,),
                                SizedBox(height: Utils.getSize(5),),
                                Row(
                                  children: [
                                    BaseText(text: "₹ 1500",fontWeight: FontWeight.w600,),

                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ) ,
                  )
                  ,
                ),
              )
            ;

          }),
          SizedBox(
            height: Utils.getSize(100),
          ),
        ],
      );
    });
  }
}







