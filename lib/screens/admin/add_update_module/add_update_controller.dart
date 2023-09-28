import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/utils.dart';

class AddUpdateController extends GetxController {
  XFile? profileImage;

  final receivedData = Get.arguments;

  TextEditingController watchNameCon = TextEditingController(),
      watchPriceCon = TextEditingController();

  String? ImageURI;

  imageGetFunc() {
    Utils.getImageSelectionBottomSheet((image) {
      profileImage = image;
      uploadImageToStorage(profileImage!.path, profileImage!.name);
      update();
    });
  }

  Future<void> uploadImageToStorage(String imagePath, String imageName) async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(imageName);
    final UploadTask uploadTask = storageRef.putFile(File(imagePath));

    await uploadTask.whenComplete(() => print('Image uploaded to storage'));
  }

  Future<String> getImageURL(String imageName) async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(imageName);
    final String downloadURL = await storageRef.getDownloadURL();

    return downloadURL;
  }

  Future<void> addImageToFirestore(String uri) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Utils.showCircularProgressLottie(true);
    await firestore.collection('watches').add({
      'image': uri ?? "",
      'name': watchNameCon.text.trim(),
      'price': "₹${watchPriceCon.text.trim()}",
      'cart': false,
      'like': false,
    });
    Utils.showCircularProgressLottie(false);
    Get.back();
  }

  Future<void> updateDetails() {
    CollectionReference watch =
        FirebaseFirestore.instance.collection('watches');
    return watch
        .doc(receivedData[0])
        .update({
          'image': ImageURI,
          'name' : watchNameCon.text.trim(),
          'price' : watchPriceCon.text.trim(),
        })
        .then((value) => Get.back())
        .catchError((error) => print("Failed to update user: $error"));
  }

  validaton(bool isTrue) async {
    if (profileImage == null) {
      Utils.showToast("Please Upload Image");
    } else if (watchNameCon.text.trim().isEmpty) {
      Utils.showToast("Please Enter name");
    } else if (watchPriceCon.text.trim().isEmpty) {
      Utils.showToast("Please Enter price");
    } else {
      if (isTrue) {
        updateDetails();
      } else {
        ImageURI = await getImageURL(profileImage!.name);
        addImageToFirestore(ImageURI!);
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    if (receivedData[1]) {
      ImageURI = receivedData[4];
      profileImage = receivedData[5];
      watchNameCon = TextEditingController(text: receivedData[2]);
      watchPriceCon = TextEditingController(text: receivedData[3]);
      update();
    }

    super.onInit();
  }
}
