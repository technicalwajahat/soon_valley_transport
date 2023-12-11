import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Controllers/user_controller.dart';
import '../Data/user_image_data.dart';
import '../Data/user_preferences.dart';
import '../Model/user_model.dart';
import '../Widget/profile_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController userController = Get.put(UserController());

  UserModel? userModel;
  late UserData user;
  bool isLoad = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoad = false;
      });
    });
    super.initState();
    _getUserDetails();
    user = UserPreferences.getUser();
  }

  Future _getUserDetails() async {
    String? uID = FirebaseAuth.instance.currentUser?.uid;
    userModel = await userController.readUser(uID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: isLoad
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText("Loading Profile...",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ))
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              children: <Widget>[
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);

                    setState(() => user = user.copy(imagePath: newImage.path));
                    UserPreferences.setUser(user);
                  },
                ),
                const SizedBox(height: 34),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.account_circle),
                    title: const AutoSizeText("Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    subtitle: AutoSizeText(
                        userModel?.fullName.toString() ?? "Unknown",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.email),
                    title: const AutoSizeText("Email",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    subtitle: AutoSizeText(
                        userModel?.email.toString() ?? "Unknown",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.phone),
                    title: const AutoSizeText("Mobile No",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    subtitle: AutoSizeText(
                      userModel?.mobileNo.toString() ?? "Unknown",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.person),
                    title: const AutoSizeText(
                      "Role",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: AutoSizeText(
                        userModel?.role.toString() ?? "Unknown",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                ),
              ],
            ),
    );
  }
}
