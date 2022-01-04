import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String personalImageURL = '';

final picker = ImagePicker();


Future takePhoto() async {
  final pickedFile = await picker.pickImage(source: ImageSource.values[0]);
  return File(pickedFile!.path);
}

Future uploadImageToFirebase(BuildContext context, Reference path, File image, String imageName) async {

  /// path should look like this =====> Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('Users/${user!.uid}${user!.phoneNumber}').child('Personal Image');
  await path.putFile(image);
  personalImageURL = await path.getDownloadURL();

}