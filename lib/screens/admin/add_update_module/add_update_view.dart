import 'package:mowat_app/base_class/base_button.dart';

import '../../../base_class/base_textfield.dart';
import '../../../constants/app.export.dart';
import '../../login/login_contoller.dart';
import 'add_update_controller.dart';

class AddUpdateView extends StatelessWidget {

   AddUpdateView({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: AddUpdateController(),
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
                text: (_.receivedData[1]!)?"Update Watch Details":"Add Watch",
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
            body: mainBody(_),
          );
        });

  }
   mainBody(AddUpdateController _) {
     return ListView(
       padding: EdgeInsets.all(16),
       physics: BouncingScrollPhysics(),
       children: [
         BaseText(
           text: "Upload Image",
           fontWeight: FontWeight.w700,
         ),
         SizedBox(
           height: Utils.getSize(10),
         ),
         GestureDetector(
           onTap: () {
             _.imageGetFunc();
           },
           child: Container(
             height: 40,
             alignment: Alignment.center,
             decoration: BoxDecoration(
               color: (_.profileImage != null)
                   ? ColorRes.primaryColor
                   : ColorRes.primaryColor.withOpacity(0.3),
               border: Border.all(color: ColorRes.primaryColor, width: 2),
               borderRadius: BorderRadius.circular(15),
             ),
             child: (_.profileImage != null)
                 ? BaseText(
               text: "Image Uploaded",
               fontWeight: FontWeight.w500,
               color: ColorRes.whiteColor,
             )
                 : BaseText(
               text: " + Upload Image",
               fontWeight: FontWeight.w500,
             ),
           ),
         ),
         SizedBox(
           height: Utils.getSize(10),
         ),
         BaseText(
           text: "Watch Name",
           fontWeight: FontWeight.w700,
         ),
         SizedBox(
           height: Utils.getSize(10),
         ),
         getTextField(controller: _.watchNameCon, hint: 'Name'),
         SizedBox(
           height: Utils.getSize(10),
         ),
         BaseText(
           text: "Watch Price",
           fontWeight: FontWeight.w700,
         ),
         SizedBox(
           height: Utils.getSize(10),
         ),
         getTextField(controller: _.watchPriceCon, hint: 'Price'),
         SizedBox(
           height: Utils.getSize(30),
         ),
         BaseRaisedButton(
           buttonText:(_.receivedData[1])?"Update":"Add",
           onPressed: () {
             _.validaton(_.receivedData[1]);
           },
           buttonVerticalPadding: 10,
         ),
       ],
     );
   }

   getTextField(
       {required String hint, required TextEditingController controller}) {
     return BaseTextField(
       borderRadius: 16,
       controller: controller,
       hintText: hint,
       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
     );
   }


}
