import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/screens/join_community.dart';
import 'package:recipes/screens/start_up2.dart';
import 'package:recipes/main.dart';


var startup1AnimationController;
class StartUpPage1 extends StatefulWidget{
  @override
  State<StartUpPage1> createState() => _StartUpPage1State();
}

class _StartUpPage1State extends State<StartUpPage1> with TickerProviderStateMixin{

  @override
  void initState()  {
    startup1AnimationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      reverseDuration: const Duration(milliseconds: forwardDuration),
      vsync: this,
    )..forward();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      startup1AnimationController.reverse();
    });
  }
 // @override
 // void dispose() {
 //   myAnimationController.dispose();
 //   super.dispose();
 // }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const Spacer(flex: 130,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 12,
                      child: AnimatedBuilder(
                        animation: startup1AnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, startup1AnimationController.value*250),
                            child: child,);
                        },
                        child: AutoSizeText(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.".toUpperCase(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 30,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 0,
                                offset: const Offset(1,1),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1,),
                  ],
                ),
                const Spacer(flex: 3,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 12,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceIn,
                        opacity: _opacity,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              startup1AnimationController = AnimationController(
                                duration: const Duration(milliseconds: forwardDuration),
                                reverseDuration: const Duration(milliseconds: forwardDuration),
                                vsync: this,
                              )..forward();
                            });
                            await Future.delayed(const Duration(milliseconds: forwardDuration));
                            NavTo(context, StartUpPage2());
                          },
                          child: const NextPageBtn(index: 0,),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(flex: 10,),
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
                  animation: startup1AnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0, startup1AnimationController.value*-200),
                      child: child,);
                  },
                  child: const CustomizableText(
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



