import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';

class RecipePage extends StatefulWidget {
  final h,w,title,subtitle,imageURL,id,index;
  const RecipePage({Key? key, this.h, this.w, this.title, this.subtitle, this.imageURL, this.id, this.index}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF121008), //i like transparent :-)
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarIconBrightness: Brightness.light, // status bar icons' color
          systemNavigationBarIconBrightness:Brightness.light, //navigation bar icons' color
      ),
      child:Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: '${widget.id} bg',
              child: Container(
                height: sh,
                width: sw,
                color: const Color(0xFFF1F1F1),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: '${widget.id} image',
                  child: Container(
                    height: sh/2,
                    width: sw,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(image: NetworkImage(widget.imageURL),fit: BoxFit.cover),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ),
                ),
                 SizedBox(
                   child: SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Hero(
                               tag: '${widget.id} title',
                               child: Align(
                                 alignment: Alignment.centerLeft,
                                 child: Padding(
                                    padding: const EdgeInsets.all(10),
                                     child: Text(widget.title ?? 'Recipe Name',style: GoogleFonts.cairo(fontWeight: FontWeight.w800,fontSize: 28),),//Title
                                 ),
                               ),
                             ),
                             Hero(
                                 tag: '${widget.id} rating',
                                 child: RatingWidget()),
                           ],
                         ),
                         Hero(
                           tag: '${widget.id} subtitle',
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Text(widget.subtitle ?? 'Recipe Name',style: GoogleFonts.cairo(fontWeight: FontWeight.w400,fontSize: 19),),//Title
                             ),
                           ),
                         ),
                         SizedBox(height: sh,)
                       ],
                     ),
                   ),
                 ),
              ],
            ),
          ],
        ),
      )
    );
  }
}