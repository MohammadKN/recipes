import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/components/components.dart';
import 'package:recipes/screens/register.dart';

class StartUpPage1 extends StatelessWidget{
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
        child: Stack(
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
                      child: CustomizableText(
                        content: "NO MORE ASKING ABOUT WHAT TO COOK",
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
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
                      child: NextPageBtn(index: 0,),
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
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => RegisterPage()));
                },
                child: CustomizableText(
                  content: "SKIP",
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



