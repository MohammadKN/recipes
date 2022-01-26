import 'package:flutter/foundation.dart';
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

  final ScrollController _scrollController = ScrollController();
  var size = 200.0;
  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF121008), //i like transparent :-)
          systemNavigationBarColor: Colors.black, // navigation bar color
          statusBarIconBrightness: Brightness.light, // status bar icons' color
          systemNavigationBarIconBrightness:Brightness.dark, //navigation bar icons' color
      ),
      child:Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Hero(
              tag: '${widget.id} bg',
              child: Container(
                height: sh,
                width: sw,
                decoration:  BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: '${widget.id} image',
                  child: Container(
                    height: size.abs(),
                    width: sw,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(image: NetworkImage(widget.imageURL),fit: BoxFit.cover),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ),
                ),
                 SizedBox(
                   height: sh/2,
                   child: NotificationListener(
                     child: SingleChildScrollView(
                       controller: _scrollController,
                       physics: const BouncingScrollPhysics(),
                       child: SizedBox(
                         child: Column(
                           children: [
                             Hero(
                               tag: '${widget.id} title',
                               child: Material(
                                 type: MaterialType.transparency,
                                 child: Container(
                                   child: Align(
                                     alignment: Alignment.centerLeft,
                                     child: Padding(
                                        padding: const EdgeInsets.all(10),
                                         child: Text(widget.title ?? 'Recipe Name',style: GoogleFonts.cairo(fontWeight: FontWeight.w800,fontSize: 28),),//Title
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             hero(
                               tag: '${widget.id} subtitle',
                               widget: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    widget.subtitle ?? 'Recipe Name',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19
                                    ),
                                  ),
                                ),
                               ),
                             ),
                             SizedBox(height: sh,)
                           ],
                         ),
                       ),
                     ),
                     onNotification: (notification) {
                       print(sh);
                       setState(() {
                         if (_scrollController.position.pixels<350)
                           size = (sh/2-_scrollController.position.pixels)/2;
                         else if (_scrollController.position.pixels<233)
                           size = sh/2-_scrollController.position.pixels;
                       });
                       if (kDebugMode) {
                         print(_scrollController.position.pixels);
                       }
                       return false;
                     },
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