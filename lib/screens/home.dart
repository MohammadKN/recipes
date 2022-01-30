import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipes/components/components.dart';
import 'add_recipe.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
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
    if (kDebugMode) {
      print('HomePage rebuilt');
    }
    var sw = MediaQuery.of(context).size.width;
    var sh = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      print('$sw ... $sh');
    }
    var _recipesStream = FirebaseFirestore.instance.collection('recipes').snapshots();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
        stream: _recipesStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty ) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(LineIcons.list)),
                      IconButton(onPressed: (){}, icon: const Icon(LineIcons.search)),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delicious Recipes',
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w700,
                          fontSize: 26
                      ),
                    ),
                  ),//title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Here You Can Find The Best Recipes.',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),//subtitle
                  const Spacer(),
                  HomePageMainTile(
                    height: sw/2-50,
                    title: '  ',
                    subtitle: '  ',
                  ),
                  //const Spacer(),
                  ////Align(
                  ////  alignment: Alignment.centerLeft,
                  ////  child: Text(
                  ////    "Categories",
                  ////    style: GoogleFonts.cairo(
                  ////        fontWeight: FontWeight.w700,
                  ////        fontSize: 22
                  ////    ),
                  ////  ),
                  //),//t
                  const Spacer(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Wrap(
                      spacing: 7,
                      children: categoriesArr.map((i) => CategoryChip(name: i.name)).toList(),
                    ),
                  ),//category
                  const Spacer(),
                  SizedBox(
                    height: sh/2.5,
                    child: SizedBox(
                      height: sh/2.5,
                      child: const Text('No Recipes Found'),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      height: 65,
                      width: sw-40,
                      decoration: BoxDecoration(
                          color: const Color(0xff121008),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(5, 15),
                                blurRadius: 20,
                                spreadRadius: 5,
                                color: Colors.black26
                            )
                          ]
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){}, icon: const Icon(LineIcons.home,color: Colors.white,)),
                          IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddRecipePage()),
                            );
                          },
                            icon: const Icon(
                              LineIcons.plus,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: const Icon(LineIcons.road,color: Colors.white,)),
                          IconButton(onPressed: (){}, icon: const Icon(LineIcons.fileContract,color: Colors.white,)),
                        ],
                      ),
                    ),
                  ),///Bottom AppBar
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(LineIcons.list)),
                    IconButton(onPressed: (){}, icon: const Icon(LineIcons.search)),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delicious Recipes',
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w700,
                          fontSize: 32
                      ),
                    ),
                  ),
                ),//title
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Here You Can Find The Best Recipes.',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),//subtitle
                HomePageMainTile(
                  height: sw/2-50,
                  title: (snapshot.data!.docs[0].data() as Map<String , dynamic> )['Name'],
                  subtitle: (snapshot.data!.docs[0].data() as Map<String , dynamic> )['Description'],
                ),
                //const Spacer(),
                ////Align(
                ////  alignment: Alignment.centerLeft,
                ////  child: Text(
                ////    "Categories",
                ////    style: GoogleFonts.cairo(
                ////        fontWeight: FontWeight.w700,
                ////        fontSize: 22
                ////    ),
                ////  ),
                //),//t
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    children: categoriesArr.map((i) => CategoryChip(name: i.name)).toList(),
                  ),
                ),//category
                const Spacer(),
                SizedBox(
                  height: sh/2.5,
                  child: snapshot.data!.docs.isEmpty?
                  SizedBox(
                    height: sh/2.7,
                    child: const Text('No Recipes Found'),
                  ) : AnimatedList(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    initialItemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, i, animation) {
                      Map<String, dynamic> data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
                      return SlideTransition(
                        position: animation
                            .drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)),
                        child: snapshot.data!.docs[i].id.isEmpty
                            ? Container()
                            : HomePageTile(
                          key: Key(snapshot.data!.docs[i].id.toString()),
                          id: snapshot.data!.docs[i].id.toString(),
                          index: i,
                          title: data['Name'].toString(),
                          subtitle: data['Description'].toString(),
                          w: sw,
                          imageURL: data['ImageURL'].toString(),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    height: 65,
                    width: sw-40,
                    decoration: BoxDecoration(
                        color: const Color(0xff121008),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(5, 15),
                              blurRadius: 20,
                              spreadRadius: 5,
                              color: Colors.black26
                          )
                        ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(LineIcons.home,color: Colors.white,)),
                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddRecipePage()),
                          );
                          },
                            icon: const Icon(
                              LineIcons.plus,
                              color: Colors.white,
                            ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(LineIcons.road,color: Colors.white,)),
                        IconButton(onPressed: (){}, icon: const Icon(LineIcons.fileContract,color: Colors.white,)),
                      ],
                    ),
                  ),
                ),///Bottom AppBar
              ],
            );
          }
          }
        ),
      ),
    );
  }
}



