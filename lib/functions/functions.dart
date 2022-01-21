import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipes/components/components.dart';
import 'package:flutter/material.dart';
import 'package:recipes/models/classes.dart';
import 'package:recipes/screens/add_recipe.dart';
import 'package:recipes/screens/register.dart';


Future<void> deleteRecipe (BuildContext context, int i, String id) async {
  AnimatedList.of(context).removeItem(i, (context, animation) {
    return SizeTransition(
      axisAlignment: -1.0,
      axis: Axis.horizontal,
      sizeFactor: animation.drive(Tween<double>(begin: 0.0,end: 0.5)),
      child: GestureDetector(
          child: HomePageTile(
            title: id.toString(),
            subtitle: id.toString(),
            //width: sw/2-65,
            //imageURL: snapshot.data!.docs[i].imageURL.toString(),
          )
      ),
    );
  });
  await Future.delayed(Duration(milliseconds: 5));

  CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');

  recipes.doc(id).delete().then((value) => print('Recipe Deleted'))
        .catchError((error) => print('Failed To Delete Recipe: $error'));

}

showToast (String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white70,
      textColor: Colors.black54,
      fontSize: 18.0);
}

Future<void> addRecipe (BuildContext context, String name, String description, String category, String id, List<dynamic> IngredientsArr, _recipeImage) async {
  List<String> difficulties = [
    'Easy',
    'Normal',
    'Hard',
    'Very Hard'
  ];
  Future<String> uploadImagesToFirebase() async {
    var  firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Users/${user!.uid}');
    await firebaseStorageRef.child('$id').putFile(_recipeImage);
    return await firebaseStorageRef.child('$id').getDownloadURL();
  }

  String imageurl = await uploadImagesToFirebase();
    if (name != '' && description != '' && category != '' && id != '' && imageurl != '') {
      DocumentReference documentReferencer = FirebaseFirestore.instance
          .collection('recipes').doc(id);

      Map<String, dynamic> recipeTemplate = <String, dynamic>{
        'Name': name,
        'Description': description,
        'Category': category,
        'difficulty': difficulties.first,
        'ImageURL': imageurl,

      };

      IngredientsArr.forEach((element) async {
        Map<String, dynamic> ingredientTemplate = <String, dynamic>{
          'Name': element.name,
          'Amount': element.amount ?? 1,
          'Unit': element.unit,
        };
        await documentReferencer.collection('Ingredients').add(ingredientTemplate)
          .whenComplete(() => print('Successfully Add To The Database'));
      });

      await documentReferencer.set(recipeTemplate)
          .whenComplete(() => print('Successfully Add To The Database'))
          .catchError((e) => print(e));

      Navigator.pop(context);
    }
  else {
   showToast('To Continue Please Fill All The Available Fields');
  }
}

Future<void> addIng(BuildContext context, String name, double amount, String unit) async {
  if (name != '' && amount != 0 && unit != '') {
    ingredientsArr.add(Ingredient(name, amount, unit));
  }

  else {
    showToast('To Continue Please Fill All The Available Fields');
  }
}

Future<void> deleteIng(String content) async {
  ingredientsArr.remove(content);
}

void NavTo (BuildContext context, dynamic destination) {
  Navigator.push(context, SlideTransitions(destination));
}
