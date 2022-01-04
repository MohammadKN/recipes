import 'package:recipes/functions/photo.dart';
import 'package:flutter/material.dart';
import 'dart:io';


Widget CircularAvatar (double radius, File _recipeImage){

  if (_recipeImage != null) {
    return GestureDetector(
      onTap: () async {
        await takePhoto();
      },
      child: CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(_recipeImage),
      ),
    );
  } else
    return GestureDetector(
      onTap: () async {
        await takePhoto();
      },
      child: CircleAvatar(
        radius: radius/11,
        backgroundImage: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FAnonymous.png?alt=media&token=91ce82aa-2620-452d-b6e9-ebbd3afc91f4'),
      ),
    );

}