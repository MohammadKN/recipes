import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:recipes/screens/register.dart';
import '../functions/functions.dart';
export 'circular_avatar.dart';

class Category {
  String name;
  bool checked;

  Category(this.name, this.checked);
}
List<Category> categoriesArr = [
  Category("Salads", false),
  Category("Snacks", true),
  Category("Breakfast", true),
  Category("Launch", true),
  Category("Dinner", true),
];


class customText extends StatelessWidget {
  final HorPad,  VerPad,  content,  color,  size, weight;
  const customText({Key? key, this.HorPad, this.VerPad, this.content, this.color, this.size, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: HorPad, vertical: VerPad),
      child: Text(
        "$content",
        style: GoogleFonts.cairo(color: color, fontSize: size, fontWeight: weight),
      ),
    );
  }
}

Widget AddIngField() {
  return TextField(
    key: ValueKey(2),
    decoration: InputDecoration(hintText: 'Add Ingredients'),
  );
}


Widget IngChip(StateSetter setModalState, String imagePath, String content, String amount, String unit) {
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
          color: isClicked ? Color(0xff000000) : Color(0xFF191919),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 0,
              offset: isClicked ? Offset(0,0) : Offset(2, 2),
              spreadRadius: isClicked ? 0 : 1,
            )
          ]
      ),
      child: Text("NEXT",
        style: GoogleFonts.quicksand(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.white.withOpacity(0.25),
              blurRadius: 0,
              offset: Offset(1,1),
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
            offset: Offset(1,1),
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
    transitionDuration: Duration(milliseconds: 0),
    pageBuilder: (context, animation, secondaryAnimation) => Target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInQuint;


      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
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
                "Email Address",
                style: GoogleFonts.quicksand(color: Color(0xAA222222),
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
                "Full Name",
                style: GoogleFonts.quicksand(color: Color(0xAA222222),
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
                "Bio",
                style: GoogleFonts.quicksand(color: Color(0xAA222222),
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
              child: Text("Password",style: GoogleFonts.quicksand(color: Color(0xAA222222),fontWeight: FontWeight.w600),),
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
                        icon: Icon(CupertinoIcons.lock),
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
        "Login",
        style: GoogleFonts.quicksand(color: Color(0xFFFFFFFF),
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
        "Register",
        style: GoogleFonts.quicksand(color: Color(0xFFFFFFFF),
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
        height: 40,
        width: 90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: categoriesArr[index].checked ? const Color(0xFFF1F1F1) : const Color(0xFF121008),
          borderRadius: BorderRadius.circular(90),
        ),
        child: Text(widget.name ?? "Salads",
          style: GoogleFonts.cairo(fontWeight: FontWeight.w400, color: categoriesArr[index].checked ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}


class HomePageTile extends StatelessWidget {
  final width,title,subtitle,imageURL;
  const HomePageTile({Key? key, this.width, this.title, this.subtitle, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        alignment: Alignment.topCenter,
        height: 250,
        width: width,
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
          maxHeight: 280,
          //maxWidth: 200,
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
                child: const CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FNicePng_plate-of-food-png_546030.png?alt=media&token=c8be3bff-3bfc-4722-8132-26a7643aeb35"),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  radius: 65,
                ),
              ),
              const SizedBox(height: 5,),
              Text("Chicken Salad",style: GoogleFonts.cairo(fontWeight: FontWeight.w600,fontSize: 19),),//Title
              Text("Chicken With Veggies",style: GoogleFonts.cairo(),),//main Ingredients
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Text("5.0",style: GoogleFonts.cairo(fontWeight: FontWeight.w600),),//Rating
                  const SizedBox(width: 5,),
                  Icon(CupertinoIcons.star_fill,color: Colors.amberAccent.shade700,size: 17),
                ],
              ),

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
      );
  }
}


class HomePageMainTile extends StatelessWidget {
  final height;
  const HomePageMainTile({Key? key, this.height}) : super(key: key);

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
              child: const CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/recipes-book-43e17.appspot.com/o/Assets%2FNicePng_plate-of-food-png_546030.png?alt=media&token=c8be3bff-3bfc-4722-8132-26a7643aeb35"),
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
                Text("Chicken Salad",style: GoogleFonts.cairo(fontWeight: FontWeight.w600,fontSize: 22),),
                Text("Chicken With Veggies",style: GoogleFonts.cairo(),),//main Ingredients
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Text("5.0",style: GoogleFonts.cairo(fontWeight: FontWeight.w600,fontSize: 20),),//Rating
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


