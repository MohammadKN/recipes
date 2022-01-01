import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'auth.dart';
import 'classes.dart';
import 'home.dart';



List<String> units = [
  'Cup',
  'TableSpoon',
  'Spoon',
  'Liter',
  'Pinch',
  'MilliLiter',
  'Packet',
  'Kilogram',
  'Gram'
];
List<Ingredient> ingredientsArr = [];
var descriptionCont = TextEditingController();
var IngSearchCont = TextEditingController();
var categoryCont = TextEditingController();
var amountCont = TextEditingController();
var unitCont = TextEditingController();
var nameCont = TextEditingController();
var idCont = TextEditingController();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              if (FirebaseAuth.instance.currentUser == null)
                SignInPage()
              else
                HomePage(),
          ],
          )
        ),
      ),
    );
  }
}


