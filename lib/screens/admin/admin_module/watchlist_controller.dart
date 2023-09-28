


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/utils.dart';



class WatchListController extends GetxController{


  XFile? profileImage;

  String? email;
  bool firstName = false;
  bool lastName = false;


  CollectionReference watch = FirebaseFirestore.instance.collection('watches');



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