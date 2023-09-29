


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mowat_app/constants/app.export.dart';

import '../../../constants/utils.dart';



class WatchListController extends GetxController{


  XFile? profileImage;

  String? email;
  bool firstName = false;
  bool lastName = false;


  CollectionReference watch = FirebaseFirestore.instance.collection('watches'),
  customerCollection = FirebaseFirestore.instance.collection(Injector.getUserId());

  // Future<void> addImageToFirestore(String uri,String name,String price) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   Utils.showCircularProgressLottie(true);
  //   await firestore.collection(Injector.getUserId()).orderBy("myFav").add({
  //     'image': uri,
  //     'name': name,
  //     'price': price,
  //     'cart': false,
  //     'like': false,
  //   });
  //   Utils.showCircularProgressLottie(false);
  //   Get.back();
  // }


  // onAddFavourite() {
  //   CollectionHelper.instance.addFavouriteOrCartProduct(product: product!, key: 'fav');
  //   update();
  // }



  Future<void> deleteWatch(String id) {
    return watch
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  String? profile_image;


  imageGetFunc(){
    Utils.getImageSelectionBottomSheet((image){
      profileImage = image;
      update();
    });
  }





}