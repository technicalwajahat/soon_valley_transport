import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Model/user_model.dart';

class UserController extends GetxController {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toMap());
  }

  Future<UserModel?> readUser(String? uid) async {
    var doc = await _userRef.doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }
}
