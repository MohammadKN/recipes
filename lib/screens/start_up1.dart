import 'package:flutter/material.dart';
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
      duration: Duration(milliseconds: 0),
      reverseDuration: Duration(milliseconds: ForwardDuration),
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
    return Scaffold(
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
                      animation: startup1AnimationController,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.translate(
                          offset: Offset(0.0, startup1AnimationController.value*250),
                          child: child,);
                      },
                      child: CustomizableText(
                        content: "NO MORE ASKING ABOUT WHAT TO COOK.",
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
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
                        animation: startup1AnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, startup1AnimationController.value*225),
                            child: child,);
                        },
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              startup1AnimationController = AnimationController(
                                duration: Duration(milliseconds: ForwardDuration),
                                reverseDuration: Duration(milliseconds: ForwardDuration),
                                vsync: this,
                              )..forward();
                            });
                            await Future.delayed(Duration(milliseconds: ForwardDuration));
                            NavTo(context, StartUpPage2());
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
                animation: startup1AnimationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(0.0, startup1AnimationController.value*-200),
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
    );
  }
}



