import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';

class JoinCommunityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/food_first_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Spacer(flex: 130,),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  Expanded(
                    flex: 12,
                    child: AutoSizeText("NOW YOU ARE      READY TO JOIN OUR COMMUNITY OF CHEFS",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 30,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 0,
                            offset: Offset(1,1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Spacer(flex: 1,),
                ],
              ),
              Spacer(flex: 3,),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  Expanded(
                    flex: 12,
                    child: GestureDetector(
                        child: NextPageBtn(index: 2,),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(flex: 10,),
            ],
          ),
        ),
      ),
    );
  }
}


