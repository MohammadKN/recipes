import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/screens/join_community.dart';
import 'package:recipes/screens/register.dart';
import 'package:recipes/screens/start_up1.dart';
import 'package:recipes/screens/start_up2.dart';
import '../functions/functions.dart';
export 'circular_avatar.dart';



Widget customText(double HorPad, double VerPad, String content, Color color, double size, FontWeight weight) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: HorPad, vertical: VerPad),
    child: Text(
      "$content",
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    ),
  );
}

Widget homePageTile(Widget title , Color primaryColor) {
  return Container(
    height: 150,
    width: 150,
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(25),
    ),
    alignment: Alignment.bottomRight,
    child: Padding(padding: EdgeInsets.all(10), child: title),
  );
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



