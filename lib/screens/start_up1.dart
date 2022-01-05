import 'package:flutter/material.dart';
import 'package:recipes/components/components.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/screens/join_community.dart';
import 'dart:math';

class StartUpPage1 extends StatefulWidget{
  @override
  State<StartUpPage1> createState() => _StartUpPage1State();
}

class _StartUpPage1State extends State<StartUpPage1> with TickerProviderStateMixin{
  var ForwardDuration = 0;
  late AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: ForwardDuration),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();


  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.forward();
      _controller.reverse();
      ForwardDuration = 500;
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.translate(
                          offset: Offset(0.0, _controller.value*250),
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
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0.0, _controller.value*225),
                            child: child,);
                        },
                        child: GestureDetector(
                          onTapUp: (s){
                            //_controller.forward();
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
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(0.0, _controller.value*-200),
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



