import 'package:recipes/functions/photo.dart';
import 'package:flutter/material.dart';


class CCircleAvatar extends StatelessWidget {
  final radius, recipeImage,backColor;
  const CCircleAvatar({Key? key, this.radius, this.recipeImage, this.backColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recipeImage != null) {
      return GestureDetector(
        onTap: () async {
          await takePhoto();
        },
        child: CircleAvatar(
          radius: radius,
          backgroundImage: FileImage(recipeImage),
          backgroundColor: backColor,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          await takePhoto();
        },
        child: CircleAvatar(
          radius: radius/11,
          backgroundColor: backColor,
          backgroundImage: const NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FAnonymous.png?alt=media&token=91ce82aa-2620-452d-b6e9-ebbd3afc91f4'),
        ),
      );
    }
  }
}
