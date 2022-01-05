import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';
import 'register.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 50,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EmailTextField(),

                    const SizedBox(
                      height: 20,
                    ),

                    const PassTextField(),

                    const SizedBox(
                      height: 20,
                    ),

                    const LoginButton(),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                          },
                          child: Text(
                            "Signup",
                            style: GoogleFonts.quicksand(
                              color: Color(0xAA222222),
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            ///Unimplemented//////////////////////////////////////////////////////////////////
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.quicksand(
                                color: Color(0xAA222222),
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(flex: 5,),
            ],
          ),
        ),
      ),
    );
  }
}