import 'package:flutter/material.dart';
import 'package:recipes/main.dart';
import 'package:get/get.dart';
import 'package:recipes/widgets/custom_widgets.dart';
import 'model/recipe.dart';

Future<void> deleteRecipe (BuildContext context, int i) async {
  AnimatedList.of(context).removeItem(i, (context, animation) {
    return SizeTransition(
      axisAlignment: -1.0,
      axis: Axis.horizontal,
      sizeFactor: animation.drive(Tween<double>(begin: 0.0,end: 1.0)),
      child: GestureDetector(
          child: homePageTile(customText(0, 0, recipesArr[i].name, Colors.white, 18, FontWeight.bold)
          )
      ),
    );
  });
  await Future.delayed(Duration(milliseconds: 10));
  recipesArr.removeAt(i);
  RecipesBox.deleteAt(i);
}

Future<void> addRecipe (BuildContext context, String name, String description, String category, String id, List<Ingredient> IngredientsArr) async {
  if (name != ""&&description != ""&&category != ""&&id != "") {
    RecipesBox.put(id, Recipe(name: name, description: description, category: category, ingredients: IngredientsArr));

    nameCont.text = "";descriptionCont.text = "";
    categoryCont.text = "";idCont.text = "";

    print('''
    $name
    $description
    $category
    $id''');
    Navigator.pop(context);
    //Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  HomePage()));
  }
  else {
    Get.snackbar(
        "There's Empty Fields",
        'To Continue Please Fill All The Available Fields',
        snackPosition: SnackPosition.BOTTOM
    );
  }
}



Future<void> addIng (BuildContext context, String name, double amount, String unit) async {
  if (name != ""&&amount != ""&&unit != "") {
    IngBox.put(name, Ingredient(name: name, amount: amount, unit: unit, ));

    nameCont.text = "";descriptionCont.text = "";
    categoryCont.text = "";idCont.text = "";

    print('''
    $name
    $amount
    $unit''');
    //Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  HomePage()));
  }
  else {
    Get.snackbar(
        "There's Empty Fields",
        'To Continue Please Fill All The Available Fields',
        snackPosition: SnackPosition.BOTTOM
    );
  }
}