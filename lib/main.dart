import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter/services.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/register.dart';
import 'package:recipes/screens/start_up1.dart';
import 'package:recipes/theme/style.dart';

const ForwardDuration = 200;

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
      theme: theme(),
      home: Stack(
        children: [
          //if (FirebaseAuth.instance.currentUser == null)
          //  LoginPage()
          //else
          StartUpPage1(),
        ],
      )
    );
  }
}