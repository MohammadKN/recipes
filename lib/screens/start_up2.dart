import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';

class StartUpPage2 extends StatefulWidget{

  @override
  State<StartUpPage2> createState() => _StartUpPage2State();
}

class _StartUpPage2State extends State<StartUpPage2> with TickerProviderStateMixin{
  var ForwardDuration = 0;

  late AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: ForwardDuration),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();

  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _controller.forward();
      await Future.delayed(Duration(milliseconds: 500));
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
      body: Container(
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
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0.0, _controller.value*200),
                        child: child,);
                    },
                    child: AutoSizeText("YOUR WAY TO COOK THE BEST RECIPES FOR YOUR CHILDREN",
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
                    animation: _controller,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0.0, _controller.value*200),
                        child: child,);
                    },
                    child: GestureDetector(
                        child: NextPageBtn(index: 1,),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(flex: 10,),
          ],
        ),
      ),
    );
  }
}


