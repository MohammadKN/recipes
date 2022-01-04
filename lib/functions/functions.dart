import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipes/components/components.dart';
import 'package:flutter/material.dart';
import 'package:recipes/models/classes.dart';
import 'package:recipes/screens/add_recipe.dart';


Future<void> deleteRecipe (BuildContext context, int i, String id) async {
  AnimatedList.of(context).removeItem(i, (context, animation) {
    return SizeTransition(
      axisAlignment: -1.0,
      axis: Axis.horizontal,
      sizeFactor: animation.drive(Tween<double>(begin: 0.0,end: 0.5)),
      child: GestureDetector(
          child: homePageTile(customText(0, 0, i.toString(), Colors.white, 18, FontWeight.bold),
            Theme.of(context).primaryColor,
          ),
      ),
    );
  });
  await Future.delayed(Duration(milliseconds: 5));

  CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');

  recipes.doc(id).delete().then((value) => print("Recipe Deleted"))
        .catchError((error) => print("Failed To Delete Recipe: $error"));

}

showToast (String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white70,
      textColor: Colors.black54,
      fontSize: 18.0);
}

Future<void> addRecipe (BuildContext context, String name, String description, String category, String id, List<dynamic> IngredientsArr, _recipeImage) async {

  Future uploadImagesToFirebase() async {
    var  firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Users/${"user!.uid"}${"user!.phoneNumber"}');
    await firebaseStorageRef.child('Recipe Image').putFile(_recipeImage);
    return await firebaseStorageRef.child('Recipe Image').getDownloadURL();
  }

  uploadImagesToFirebase();
    if (name != "" && description != "" && category != "" && id != "") {
      DocumentReference documentReferencer = FirebaseFirestore.instance
          .collection('recipes').doc(id);

      Map<String, dynamic> recipeTemplate = <String, dynamic>{
        "Name": name,
        "description": description,
        "Category": category,
      };


      IngredientsArr.forEach((element) async {
        Map<String, dynamic> ingredientTemplate = <String, dynamic>{
          "Name": element.name,
          "Amount": element.amount,
          "Unit": element.unit,
        };
        await documentReferencer.collection("Ingredients").add(ingredientTemplate)
          .whenComplete(() => print("Successfully Add To The Database"));
      });

      await documentReferencer.set(recipeTemplate)
          .whenComplete(() => print("Successfully Add To The Database"))
          .catchError((e) => print(e));




      Navigator.pop(context);
    }
  else {
   showToast('To Continue Please Fill All The Available Fields');
  }
}

Future<void> addIng(BuildContext context, String name, double amount, String unit) async {
  if (name != "" && amount != "" && unit != "") {

    ingredientsArr.add(Ingredient(name, amount, unit));



  }
  else {
    showToast('To Continue Please Fill All The Available Fields');
  }
}

Future<void> deleteIng(String content) async {
  ingredientsArr.remove(content);
}
