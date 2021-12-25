import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipes/classes.dart';
import 'package:recipes/main.dart';
import 'package:get/get.dart';
import 'package:recipes/custom_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> deleteRecipe (BuildContext context, int i) async {
  AnimatedList.of(context).removeItem(i, (context, animation) {
    return SizeTransition(
      axisAlignment: -1.0,
      axis: Axis.horizontal,
      sizeFactor: animation.drive(Tween<double>(begin: 0.0,end: 1.0)),
      child: GestureDetector(
          child: homePageTile(customText(0, 0, i.toString(), Colors.white, 18, FontWeight.bold)
          )
      ),
    );
  });
  await Future.delayed(Duration(milliseconds: 5));
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
Future<void> addRecipe (BuildContext context, String name, String description, String category, String id, List<dynamic> IngredientsArr) async {

  

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
          .whenComplete(() => print("Successfully Add To The Database"))
          .catchError((e) => print(e));
      });

      await documentReferencer.set(recipeTemplate)
          .whenComplete(() => print("Successfully Add To The Database"))
          .catchError((e) => print(e));

      nameCont.text = "";
      descriptionCont.text = "";
      categoryCont.text = "";
      idCont.text = "";


      Navigator.pop(context);
    }
  else {
   showToast('To Continue Please Fill All The Available Fields');
  }
}




void deleteIng(String key) {
}

Future<void> addIng(BuildContext context, String name, double amount, String unit, String recipeID) async {
  if (name != "" && amount != "" && unit != "") {
    
    ingredientsArr.add(Ingredient(name, amount, units));
    
    IngSearchCont.clear();
    amountCont.clear();
    dropdownValue = "Kilogram";


  }
  else {
    showToast('To Continue Please Fill All The Available Fields');
  }
}
