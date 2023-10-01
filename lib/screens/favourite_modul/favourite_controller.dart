


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mowat_app/constants/app.export.dart';

class FavouriteController extends GetxController{
  CollectionReference
      customerCollection = FirebaseFirestore.instance.collection(Injector.getUserId());



  Future addFavouriteOrCartProduct(DocumentSnapshot data,String key) async {
    Utils.showCircularProgressLottie(true);
    QuerySnapshot collection = await customerCollection.get();
    List<QueryDocumentSnapshot<Object?>> docId = collection.docs;
    DocumentReference userRef = customerCollection.doc(docId[0].id);
    DocumentSnapshot userSnapshot = await userRef.get();
    Utils.showCircularProgressLottie(false);
    List existingArray = userSnapshot.get(key);
    existingArray.add({
      'image': data['image'],
      'name':  data['name'],
      'price': data['price'],
    });
    Set removeData = {};
    List<Map<String, dynamic>> uniqueList = [];
    for (var item in existingArray) {
      if(key == 'myFav') {
        if (removeData.add(item['name'])) {
          uniqueList.add(item);
        }
      }
      if(key == 'myCart') {
        if (removeData.add(item)) {
          uniqueList.add(item);
        }
      }
    }
    return await userRef.update({key: uniqueList})
        .then((value) {

      debugPrint("Product Added..");
      Utils.showToast( 'Successfully Added...');
    })
        .catchError((error) {
      debugPrint("Failed to add: $error");
      Utils.showToast( 'Failed...');
    });



  }

  Future<void> deleteWatch(String id) {
    return customerCollection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }








}