import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'custom_widgets.dart';
import 'functions.dart';

ThemeData _themeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primaryColorDark: Colors.red,
      primarySwatch: Colors.red,
      accentColor: Colors.red,
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  void initState() {
    _initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage rebuilt');
    var sw = MediaQuery.of(context).size.width;
    var sh = MediaQuery.of(context).size.height;
    var _recipesStream = FirebaseFirestore.instance.collection('recipes').snapshots();

    return MaterialApp(
      theme: _themeData(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: Key("HomePageKey"),
          resizeToAvoidBottomInset: true,
          body: StreamBuilder<QuerySnapshot>(
            stream: _recipesStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ); else
              return Container(
                height: sh,
                width: sw,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(10, 15, "First Row", Colors.black, 32, FontWeight.bold),
                            SizedBox(
                              height: 150,
                              child: AnimatedList(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                initialItemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, i, animation) {
                                  return SlideTransition(
                                    position: animation
                                        .drive(Tween(begin: Offset(1.0, 0.0), end: Offset.zero)),
                                    child: GestureDetector(
                                        onLongPress: () async {
                                          setState(() {
                                            deleteRecipe(
                                                context, i, snapshot.data!.docs[i].id.toString());
                                          });
                                        },
                                        child: snapshot.data!.docs[i].id.isEmpty
                                            ? Container()
                                            : homePageTile(
                                                customText(0, 0, snapshot.data!.docs[i].id.toString(),
                                                    Colors.white, 18, FontWeight.bold),
                                                Theme.of(context).primaryColor,
                                              )),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddRecipePage()),
                            );
                          },
                          child: Text("add"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
