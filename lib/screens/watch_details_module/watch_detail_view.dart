import '../../constants/app.export.dart';

class WatchDetailView extends StatelessWidget {
  bool isTrue ;

   WatchDetailView({super.key,required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WatchDetailController(),
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
              actions: [
                GestureDetector(
                  onTap: (){
                    if(isTrue){_.addFavouriteOrCartProduct(_.receivedData[0],"myCart");
                    _.update();
                    }
                    else{
                      Utils.showToast("Already Added");
                    }

                  },
                  child: Container(
                    height: Utils.getSize(50),
                    width: Utils.getSize(50),
                    alignment: Alignment.center,
                    color: ColorRes.transparentColor,
                    child: Icon(Icons.shopping_cart,color: ColorRes.primaryColor,),
                  ),
                ),
              ],
              backgroundColor: ColorRes.transparentColor,
              centerTitle: true,
              title: BaseText(
                text: "Details",
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
            backgroundColor: ColorRes.greyColor,
            body: mainBody(_),
            floatingActionButton: GestureDetector(
              onTap: () {

              },
              child: AnimatedContainer(
                height: 50,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorRes.primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                duration: Duration(milliseconds: 600),
                child: BaseText(
                  text: "Buy",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        });
  }


  mainBody(WatchDetailController _){
    var data = _.receivedData[0];
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Image.network(
              data['image'] ?? "",
              height: Utils.getSize(300),
              width: Utils.getSize(300),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                color: ColorRes.whiteColor),
            child: ListView(
              children: [
                Row(
                  children: [
                    BaseText(
                      text: data['name'] ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap : (){
                          if(isTrue){
                            _.addFavouriteOrCartProduct(data,"myFav");
                            _.update();
                          }
                          else{
                            Utils.showToast("Already Added");
                          }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorRes.primaryColor),
                            child: Icon(
                              Icons.favorite,
                              size: 18,
                              color: ColorRes.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Utils.getSize(5),
                        ),
                        BaseText(
                          text: "Favourite",
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getSize(10),
                ),
                BaseText(
                  text: "⭐⭐⭐⭐4.5",
                  color: ColorRes.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                SizedBox(
                  height: Utils.getSize(10),
                ),
                BaseText(
                  text: "Connectivity",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: Utils.getSize(5),
                ),
                BaseText(
                  text:
                  "System Requirement : iOS 11.0  & + or Android 5.0 & +\nBT : v5.0",
                  color: ColorRes.textGreyColor,fontSize: 16,fontWeight: FontWeight.w600,
                ),
                SizedBox(height: Utils.getSize(10),),
                BaseText(
                  text: "Display",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: Utils.getSize(5),
                ), BaseText(
                  text:
                  "Display technology : LCD\nSize : 1.28”\nResolution : 240*240\nCloud-based watch faces : Yes\nSENSORS",
                  color: ColorRes.textGreyColor,fontSize: 16,fontWeight: FontWeight.w600,
                ),
                SizedBox(height: Utils.getSize(10),),
                BaseText(
                  text: "Price",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: Utils.getSize(5),
                ),
                BaseText(
                  text:data['price'] ?? "",
                  color: ColorRes.blackColor,fontSize: 26,fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


