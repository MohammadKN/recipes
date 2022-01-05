import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes/components/components.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:io';


var nameCont = TextEditingController();
var emailCont = TextEditingController();
var passwordCont = TextEditingController();
var bioCont = TextEditingController();
var fb = FirebaseFirestore.instance;
late File anonImage;
var user = FirebaseAuth.instance.currentUser;



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String personalImageURL = '',cardImageURL = '';
  final picker = ImagePicker();
  var _personalImage;
  bool imageA = false;
  Future takePersonalPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.values[0]);
    setState(() {
      _personalImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.topCenter,
            height: sh,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () async {
                      await takePersonalPhoto();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      //backgroundImage: FileImage(anonImage),
                      radius: 65,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const NameTextField(),

                      const SizedBox(
                        height: 20,
                      ),

                      const BioTextField(),

                      const SizedBox(
                        height: 20,
                      ),

                      const EmailTextField(),

                      const SizedBox(
                        height: 20,
                      ),

                      const PassTextField(),

                      const SizedBox(
                        height: 20,
                      ),

                      const RegisterButton(),

                      const SizedBox(
                        height: 20,
                      ),

                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.quicksand(
                              color: Color(0xAA222222),
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



