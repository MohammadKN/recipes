import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/screens/join_community.dart';
import 'package:recipes/screens/start_up1.dart';
import 'package:recipes/main.dart';

var startup2AnimationController;
class StartUpPage2 extends StatefulWidget{
  @override
  State<StartUpPage2> createState() => _StartUpPage2State();
}

class _StartUpPage2State extends State<StartUpPage2> with TickerProviderStateMixin{

  @override
  void initState()  {
    startup2AnimationController = AnimationController(
      duration: Duration(milliseconds: 0),
      reverseDuration: Duration(milliseconds: ForwardDuration),
      vsync: this,
    )..forward();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      startup2AnimationController.reverse();
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
          startup2AnimationController = AnimationController(
            duration: Duration(milliseconds: ForwardDuration),
            reverseDuration: Duration(milliseconds: ForwardDuration),
            vsync: this,
          )..forward();
        });
        await Future.delayed(Duration(milliseconds: ForwardDuration));
        NavTo(context, StartUpPage1());
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
                        animation: startup2AnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, startup2AnimationController.value*250),
                            child: child,);
                        },
                        child: AutoSizeText(
                          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.".toUpperCase(),
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
                        animation: startup2AnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, startup2AnimationController.value*225),
                            child: child,);
                        },
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              startup2AnimationController = AnimationController(
                                duration: Duration(milliseconds: ForwardDuration),
                                reverseDuration:  Duration(milliseconds: ForwardDuration),
                                vsync: this,
                              )..forward();
                            });
                            await Future.delayed(Duration(milliseconds: ForwardDuration));
                            NavTo(context, JoinCommunityPage());
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
                  NavTo(context, JoinCommunityPage());
                },
                child: AnimatedBuilder(
                  animation: startup2AnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0, startup2AnimationController.value*-200),
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