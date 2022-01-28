// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:recipes/screens/add_recipe.dart';
import 'package:recipes/screens/recipe.dart';
import 'package:recipes/screens/register.dart';
import '../functions/functions.dart';
export 'circular_avatar.dart';

class Category {
  String name;
  bool checked;

  Category(this.name, this.checked);
}
List<Category> categoriesArr = [
  Category('Salads', false),
  Category('Snacks', true),
  Category('Breakfast', true),
  Category('Launch', true),
  Category('Dinner', true),
];

class customText extends StatelessWidget {
  final HorPad,  VerPad,  content,  color,  size, weight;
  const customText({Key? key, this.HorPad, this.VerPad, this.content, this.color, this.size, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: HorPad, vertical: VerPad),
      child: Text(
        '$content',
        style: GoogleFonts.cairo(color: color, fontSize: size, fontWeight: weight),
      ),
    );
  }
}


class IngChip extends StatelessWidget {
  final setModalState, imagePath, content, amount, unit;
  const IngChip({Key? key, this.setModalState, this.imagePath, this.content, this.amount, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onLongPress: () => setModalState(() => deleteIng(content)),
        child: Chip(
          avatar: CircleAvatar(
            foregroundImage: NetworkImage(imagePath),
            foregroundColor: Colors.blueAccent,
          ),
          label: Text(content),
          backgroundColor: Colors.grey[300],
        ),
      );
  }
}



class NextPageBtn extends StatefulWidget {
  final int index;
  const NextPageBtn({Key? key, required this.index}) : super(key: key);

  @override
  _NextPageBtnState createState() => _NextPageBtnState();
}

class _NextPageBtnState extends State<NextPageBtn> {

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
          color: isClicked ? const Color(0xff000000) : const Color(0xFF191919),
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 0,
              offset: isClicked ? const Offset(0,0) : const Offset(2, 2),
              spreadRadius: isClicked ? 0 : 1,
            )
          ]
      ),
      child: Text('NEXT',
        style: GoogleFonts.quicksand(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.white.withOpacity(0.25),
              blurRadius: 0,
              offset: const Offset(1,1),
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomizableText extends StatelessWidget {
  final String content;
  final FontWeight fontWeight;
  final fontSize;
  const CustomizableText({Key? key,required this.content, required this.fontWeight, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(content,
      style: GoogleFonts.quicksand(
        fontWeight: fontWeight,
        color: Colors.black,
        fontSize: fontSize,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 0,
            offset: const Offset(1,1),
            spreadRadius: 0,
          ),
        ],
      ),
      maxLines: 2,
    );
  }
}

Route SlideTransitions (var Target) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => Target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInQuint;


      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}



class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFFEFEFE),
        boxShadow: [
          BoxShadow(
              blurRadius: 25,
              offset: const Offset(0,10),
              spreadRadius: 5,
              color: Colors.red.withOpacity(0.2)
          )
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Email Address',
                style: GoogleFonts.quicksand(color: const Color(0xAA222222),
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailCont,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFFEFEFE),
        boxShadow: [
          BoxShadow(
              blurRadius: 25,
              offset: const Offset(0,10),
              spreadRadius: 5,
              color: const Color(0xFFFF0000).withOpacity(0.2)
          )
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Full Name',
                style: GoogleFonts.quicksand(color: const Color(0xAA222222),
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameCont,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person_outline),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BioTextField extends StatelessWidget {
  const BioTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFFEFEFE),
        boxShadow: [
          BoxShadow(
              blurRadius: 25,
              offset: const Offset(0,10),
              spreadRadius: 5,
              color: const Color(0xFFFF0000).withOpacity(0.2)
          )
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Bio',
                style: GoogleFonts.quicksand(color: const Color(0xAA222222),
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: bioCont,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person_outline),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class PassTextField extends StatefulWidget {
  const PassTextField({Key? key}) : super(key: key);

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFFEFEFE),
        boxShadow: [
          BoxShadow(
              blurRadius: 25,
              offset: const Offset(0,10),
              spreadRadius: 5,
              color: const Color(0xFFFF0000).withOpacity(0.2)
          )
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text('Password',style: GoogleFonts.quicksand(color: const Color(0xAA222222),fontWeight: FontWeight.w600),),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: passwordCont,
                      obscureText: _obscure ? true : false,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        icon: const Icon(CupertinoIcons.lock),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: (){
                            if (_obscure) {
                              setState(() {
                                _obscure = false;
                              });
                            } else {
                              setState(() {
                                _obscure = true;
                              });
                            }
                          },
                          child: Icon(_obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'Login',
        style: GoogleFonts.quicksand(color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'Register',
        style: GoogleFonts.quicksand(color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}




class CategoryChip extends StatefulWidget {
  final name;
  const CategoryChip({Key? key, this.name}) : super(key: key);

  @override
  _CategoryChipState createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    final index = categoriesArr.indexWhere((e) => e.name == widget.name,);
    return GestureDetector(
      onTap: (){
        if (categoriesArr[index].checked) {
          setState(() {
            categoriesArr[index].checked = false;
          });
        } else {
          setState(() {
            categoriesArr[index].checked = true;
          });
        }
      },
      child: Container(
        key: Key(widget.name),
        margin: const EdgeInsets.symmetric(horizontal: 7),
        height: 40,
        width: 90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: categoriesArr[index].checked ? const Color(0xFFF1F1F1) : const Color(0xFF121008),
          borderRadius: BorderRadius.circular(90),
        ),
        child: Text(widget.name ?? 'Salads',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w400, color: categoriesArr[index].checked ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}

class AddRecipeForm extends StatelessWidget {
  const AddRecipeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            //CircularAvatar(screenHeight / 11, _recipeImage),
            TextField(
              controller: nameCont,
              textInputAction: TextInputAction.next,
              //autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: AddRecipePageState().descriptionCont,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: AddRecipePageState().categoryCont,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: AddRecipePageState().idCont,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            OutlinedButton(
                key: const Key('Add Ingredients Btn'),
                onPressed: ()async {
                  AddRecipePageState().stackChanger(1);
                },
                child: const Text('Add Ingredients')
            ),
            ElevatedButton(
                onPressed: () => addRecipe(context, nameCont.text, AddRecipePageState().descriptionCont.text,
                    AddRecipePageState().categoryCont.text, AddRecipePageState().idCont.text, ingredientsArr, AddRecipePageState().recipeImage),
                child: const Text('Add Recipe')
            ),
          ]);
  }
}


class HomePageTile extends StatelessWidget {
  final h,w,title,subtitle,imageURL,id,index;
  const HomePageTile({Key? key, this.w, this.title, this.subtitle, this.imageURL, this.h, this.id, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () async {
            deleteRecipe(
                context, index, id);
        },
        onTap: (){
          NavTo(context,  RecipePage(title: title,subtitle: subtitle,imageURL: imageURL,id: id,index: index,));
        },
        child: Container(
          height: 300,
          width: w/2-65,
          margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Stack(
            children: [
              hero(
                tag: '$id bg',
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 300,
                  width: w/2-65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(90),
                    //boxShadow: [
                    //  BoxShadow(
                    //      offset: Offset(0, 15),
                    //      blurRadius: 20,
                    //      spreadRadius: 5,
                    //      color: Colors.deepOrange.shade100
                    //  )
                    //]
                  ),
                ),
              ),
                OverflowBox(
                  maxHeight: 320,
                  maxWidth: w/2-65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(5, 15),
                                blurRadius: 12,
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.12)
                            )
                          ],
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: hero(
                          tag: '$id image',
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(
                                imageURL ?? 'https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FNicePng_plate-of-food-png_546030.png?alt=media&token=c8be3bff-3bfc-4722-8132-26a7643aeb35'),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            radius: 65,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      hero(
                        tag: '$id title',
                        child: Material(
                          color:Colors.transparent,
                          child: Text(
                            title ?? 'Recipe Name',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              fontSize: 19
                            ),
                          )
                        )
                      ),//Title
                      hero(
                          tag: '$id subtitle',
                          child: Text(subtitle ?? 'Main Ingredients',style: GoogleFonts.cairo(),)),//main Ingredients
                      hero(
                          tag: '$id rating',
                          child: const RatingWidget()),

                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xff121008),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const Icon(LineIcons.plus,color: Colors.white,size: 17,),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Text('5.0',style: GoogleFonts.cairo(fontWeight: FontWeight.w600),),//Rating
        const SizedBox(width: 5,),
        Icon(CupertinoIcons.star_fill,color: Colors.amberAccent.shade700,size: 17),
      ],
    );
  }
}

class HomePageMainTile extends StatelessWidget {
  final height,title,subtitle,imageURL;
  const HomePageMainTile({Key? key, this.height, this.title, this.subtitle, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.centerLeft,
      height: height,
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(90),
        //boxShadow: [
        //  BoxShadow(
        //      offset: Offset(0, 15),
        //      blurRadius: 20,
        //      spreadRadius: 5,
        //      color: Colors.deepOrange.shade100
        //  )
        //]
      ),
      child: OverflowBox(
        maxWidth: 370,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5, 15),
                      blurRadius: 12,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.12)
                  )
                ],
                borderRadius: BorderRadius.circular(90),
              ),
              child: CircleAvatar(
                foregroundImage: NetworkImage(
                    imageURL ?? 'https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FNicePng_plate-of-food-png_546030.png?alt=media&token=c8be3bff-3bfc-4722-8132-26a7643aeb35'),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                radius: 75,
              ),
            ),
            const SizedBox(width: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title ?? 'Recipe Name',style: GoogleFonts.cairo(fontWeight: FontWeight.w600,fontSize: 22),),
                Text(subtitle ?? 'Main Ingredient',style: GoogleFonts.cairo(),),//main Ingredients
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Text('5.0',style: GoogleFonts.cairo(fontWeight: FontWeight.w600,fontSize: 20),),//Rating
                    const SizedBox(width: 5,),
                    Icon(CupertinoIcons.star_fill,color: Colors.amberAccent.shade700,size: 20),
                  ],
                ),
              ],
            ),//Title
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xff121008),
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Icon(LineIcons.plus,color: Colors.white,size: 20,),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Choose Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('Camera'),
                onPressed: () {
                  AddRecipePageState().takePersonalPhoto();
                },
              ),
              TextButton(
                child: const Text('Device Files'),
                onPressed: () {
                  Navigator.pop(context);
                  AddRecipePageState().pickPersonalPhoto();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

class hero extends StatelessWidget {
  final tag,child;
  const hero({Key? key, this.tag, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          child: child,
        ),
      ),
    );
  }
}

