


import 'package:flutter/material.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Container(
            width: sw,
            height: sh,
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Spacer(flex: 1,),
                Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailCont,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            suffixIcon: Icon(Icons.email_outlined),
                          ),
                        ),

                        TextField(
                          controller: passwordCont,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: Icon(Icons.password),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text("Sign In"),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                          },
                          child: Text("Don't Have An Account?"),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
