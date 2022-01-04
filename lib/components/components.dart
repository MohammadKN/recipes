import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/screens/join_community.dart';
import 'package:recipes/screens/register.dart';
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
    return GestureDetector(
      onTapDown: (s){
        setState(() {
          isClicked = true;
        });
      },

      onTapUp: (s){
        setState(() {
          isClicked = false;
          if (widget.index == 0)
            Navigator.push(context, CupertinoPageRoute(builder: (context) => StartUpPage2()));
          else if (widget.index == 1)
            Navigator.push(context, CupertinoPageRoute(builder: (context) => JoinCommunityPage()));
          else
            Navigator.push(context, CupertinoPageRoute(builder: (context) => RegisterPage()));
        });
      },

      child: Container(
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
        child: Text("NEXTA",
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

