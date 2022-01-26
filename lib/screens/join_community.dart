import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/screens/register.dart';
import 'package:recipes/screens/start_up2.dart';
import 'package:recipes/main.dart';


var joinAnimationController;
class JoinCommunityPage extends StatefulWidget{
  @override
  State<JoinCommunityPage> createState() => _JoinCommunityPageState();
}

class _JoinCommunityPageState extends State<JoinCommunityPage> with TickerProviderStateMixin{

  @override
  void initState()  {
    joinAnimationController = AnimationController(
      duration: Duration(milliseconds: 0),
      reverseDuration: Duration(milliseconds: forwardDuration),
      vsync: this,
    )..forward();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //myAnimationController.forward();
      joinAnimationController.reverse();
    });
  }
  // @override
  // void dispose() {
  //   myAnimationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          joinAnimationController = AnimationController(
            duration: Duration(milliseconds: forwardDuration),
            reverseDuration: Duration(milliseconds: forwardDuration),
            vsync: this,
          )..forward();
        });
        await Future.delayed(Duration(milliseconds: forwardDuration));
        NavTo(context, StartUpPage2());
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Spacer(flex: 130,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 12,
                      child: AnimatedBuilder(
                        animation: joinAnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, joinAnimationController.value*250),
                            child: child,);
                        },
                        child: AutoSizeText("Lacus vestibulum sed arcu non odio euismod lacinia.".toUpperCase(),
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
                          maxLines: 4,
                        ),
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
                      child: AnimatedBuilder(
                        animation: joinAnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, joinAnimationController.value*225),
                            child: child,);
                        },
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              joinAnimationController = AnimationController(
                                duration: Duration(milliseconds: forwardDuration),
                                reverseDuration: Duration(milliseconds: forwardDuration),
                                vsync: this,
                              )..forward();
                            });
                            await Future.delayed(Duration(milliseconds: forwardDuration));
                            NavTo(context, RegisterPage());
                          },
                          child: NextPageBtn(index: 0,),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(flex: 10,),
              ],
            ),
            Positioned(
              top: 30,
              right: 30,
              child: GestureDetector(
                onTap: (){
                  NavTo(context, RegisterPage());
                },
                child: AnimatedBuilder(
                  animation: joinAnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0, joinAnimationController.value*-200),
                      child: child,);
                  },
                  child: CustomizableText(
                    content: "SKIP",
                    fontWeight: FontWeight.w600,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






