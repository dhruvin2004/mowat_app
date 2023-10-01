


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyCartController extends GetxController{


  CollectionReference watch = FirebaseFirestore.instance.collection('watches');


  Future<void> deleteWatch(String id) {
    return watch
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }


}