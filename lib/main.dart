import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'classes.dart';
import 'custom_widgets.dart';
import 'functions.dart';

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
          body: HomePage(),
        ),
      ),
    );
  }
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
    final Stream<QuerySnapshot> _recipesStream = FirebaseFirestore.instance.collection('recipes').snapshots();

    return SafeArea(
        child: Scaffold(
            key: Key("HomePageKey"),
            resizeToAvoidBottomInset: true,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showBottomSheet(context);
              },
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _recipesStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null)
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
                                              deleteRecipe(context, i);
                                            });
                                          },
                                          child: homePageTile(
                                              customText(
                                              0,
                                              0,
                                              snapshot.data!.docs[i].id.toString(),
                                              Colors.white,
                                              18,
                                              FontWeight.bold
                                          )
                                        )
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red,
                    ),
                  ),
                );
              }
              )
        )
    );
}
}
