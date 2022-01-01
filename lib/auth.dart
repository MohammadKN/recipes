import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:recipes/home.dart';

var nameCont = TextEditingController();
var emailCont = TextEditingController();
var passwordCont = TextEditingController();
var bioCont = TextEditingController();
var fb = FirebaseFirestore.instance;
late File anonImage;
var user = FirebaseAuth.instance.currentUser;


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final refs = fb.collection('users');

  String personalImageURL = '';

  final picker = ImagePicker();

  var _personalImage;

  Future takePersonalPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.values[0]);
    setState(() {
      _personalImage = File(pickedFile!.path);
    });
  }

  Future uploadImagesToFirebase(BuildContext context) async {
    var  firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Users/${user!.uid}${user!.phoneNumber}');
    await firebaseStorageRef.child('Personal Image').putFile(_personalImage);
    personalImageURL =await firebaseStorageRef.child('Personal Image').getDownloadURL();
  }

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
                        if (_personalImage != null)
                          GestureDetector(
                            onTap: () async {
                              await takePersonalPhoto();
                              await uploadImagesToFirebase(context);
                            },
                            child: CircleAvatar(
                              radius: sh/11,
                              backgroundImage: FileImage(_personalImage),
                            ),
                          ),
                        if (_personalImage == null)
                          GestureDetector(
                            onTap: () async {
                              await takePersonalPhoto();
                            },
                            child: CircleAvatar(
                              radius: sh/11,
                              backgroundImage: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/bus-jo.appspot.com/o/Assets%2FAnonymous.png?alt=media&token=fccfa75f-20f1-43b3-9a5f-6efc705fabc5'),
                            ),
                          ),

                        TextField(
                          controller: nameCont,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Name",
                            suffixIcon: Icon(Icons.person_outline),
                          ),
                        ),

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

                        TextField(
                          controller: bioCont,
                          textInputAction: TextInputAction.next,

                          decoration: InputDecoration(
                              labelText: "Bio",
                              suffixIcon: Icon(Icons.edit),
                              hintText: "Here You Can Write Your Skills",
                              hintStyle: TextStyle(color: Colors.black45)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailCont.text,
                                  password: passwordCont.text,
                              ).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage())));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print('The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text("Sign Up"),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                          },
                            child: Text("Already A Member?")),
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



class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
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
