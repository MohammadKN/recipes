import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/components/components.dart';

class NewPage extends StatefulWidget {
  final title,subtitle,imageURL,id,index,h,w;
  const NewPage({Key? key, this.title, this.subtitle, this.imageURL, this.id, this.index, this.h, this.w}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  final ScrollController _scrollController = ScrollController();
  var size = 200.0;
  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF121008),
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness:Brightness.dark,
      ),
      child:Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            hero(
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
                hero(
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
                       primary: false,
                       controller: _scrollController,
                       physics: const BouncingScrollPhysics(),
                       child: SizedBox(
                         child: Column(
                           children: [
                             hero(
                               tag: '${widget.id} title',
                                 child: Align(
                                   alignment: Alignment.centerLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.all(10),
                                     child: Text(
                                       widget.title ?? 'Recipe Name',
                                       style: GoogleFonts.cairo(
                                         fontWeight: FontWeight.w800,
                                         fontSize: 28
                                       ),
                                     ),//Title
                                   ),
                                 ),
                             ),
                             hero(
                               tag: '${widget.id} subtitle',
                               child: Align(
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
                         if (_scrollController.position.pixels<350) {
                           size = (sh/2-_scrollController.position.pixels)/2;
                         } else if (_scrollController.position.pixels<233) {
                           size = sh/2-_scrollController.position.pixels;
                         }
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

class RecipePage extends StatefulWidget {
  final h,w,title,subtitle,imageURL,id,index;
  const RecipePage({Key? key, this.h, this.w, this.title, this.subtitle, this.imageURL, this.id, this.index}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  ScrollController scrollController = ScrollController();
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener(
        onNotification: (notification){
          if (scrollController.position.pixels < -150 && isTap == false) {
            scrollController.dispose();
            Navigator.pop(context);
          }
          if (scrollController.position.pixels > scrollController.position.maxScrollExtent+150){
            scrollController.dispose();
            Navigator.pop(context);
          }
          return false;
        },
        child: DraggableScrollableSheet(
          builder: (context , sC) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: GestureDetector(
              onTapDown: (t){
                isTap = true;
                print(isTap);
              },
              onTapUp: (t){
                isTap = false;
                print(isTap);
              },
              child: Stack(
                children: [
                  /*hero(
                    tag: '$id bg',
                    child: Container(
                      height: h,
                      width: w,
                      decoration:  BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hero(
                        tag: '${widget.id} image',
                        child: GestureDetector(
                          child: Container(
                            height: s.height/3,
                            width: s.width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(widget.imageURL),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  width: 140,
                                  height: 14,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(CupertinoIcons.star_fill,color: Colors.amberAccent,),
                                      Icon(CupertinoIcons.star_fill,color: Colors.amberAccent,),
                                      Icon(CupertinoIcons.star_fill,color: Colors.amberAccent,),
                                      Icon(CupertinoIcons.star_fill,color: Colors.amberAccent,),
                                      Icon(CupertinoIcons.star_fill,color: Colors.amberAccent,),
                                    ],
                                  ),
                                ),
                                const Text('5.0 (Rated 999)'),
                              ],
                            ),
                            hero(
                              tag: '${widget.id} title',
                              child: Text(
                                widget.title ?? 'Recipe Name',
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w800,
                                    fontSize:20),
                              ),
                            ),
                            Wrap(
                              spacing: 5,
                              children: const [
                                TagChip(title: 'Rice',),
                                TagChip(title: 'Launch',),
                                TagChip(title: 'Cooked Yoghurt',),
                                TagChip(title: 'Meat',),
                              ],
                            ),
                            Divider(
                              height: s.height/50,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.person,
                                        size: 45,
                                        color: Colors.black38,
                                      ),
                                      Text('6 Persons'),
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.clock,
                                        size: 45,
                                        color: Colors.black38,
                                      ),
                                      Text('3h'),
                                    ],
                                  ),
                                  hero(
                                    tag: '${widget.id} subtitle',
                                    child: Column(
                                      children:  [
                                        const Icon(
                                          CupertinoIcons.timer,
                                          size: 45,
                                          color: Colors.black38,
                                        ),
                                        Text(widget.subtitle=='null' ? 'Difficulty' : widget.subtitle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: s.height/50,
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.red,
                                  foregroundImage: NetworkImage(
                                      'https://yt3.ggpht.com/ytc/AKedOLQZ41gNDwIZDc6dYQu-b1rgqCVriRiY9nwGPhPomA=s88-c-k-c0x00ffffff-no-rj'),
                                ),
                                const SizedBox(width: 5,),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Mohammad KN',
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.black
                                        ),
                                      ),
                                      const TextSpan(text: '\n',),
                                      TextSpan(
                                        text: '1 Recipe',
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w500,
                                            fontSize:14,
                                            color: Colors.black45,
                                            height: 0.7
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              height: s.height/50,
                            ),
                            Text(
                              'Ingredients',
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                fontSize:20,
                              ),
                            ),
                            Column(
                              children: [
                                IngTile(
                                  width: s.width*0.88,
                                  height: 55.0,
                                  title: 'Meat',
                                  amount: '2 Kilograms',
                                  imageURL: 'https://chikplaza.com/wp-content/uploads/2017/09/Mutton-Mix-Assorted-Curry-Cut_STP3627-1.jpg',
                                ),
                                Divider(
                                  height: s.height/50,
                                  thickness: 1,
                                ),
                                IngTile(
                                  width: s.width*0.88,
                                  height: 55.0,
                                  title: 'Rice',
                                  amount: '1200 Grams',
                                  imageURL: 'https://cdn.loveandlemons.com/wp-content/uploads/2020/03/how-to-cook-rice.jpg',
                                ),
                                Divider(
                                  height: s.height/50,
                                  thickness: 1,
                                ),
                                IngTile(
                                  width: s.width*0.88,
                                  height: 55.0,
                                  title: 'Yoghurt',
                                  amount: '2 Kilograms',
                                  imageURL: 'https://sahhawhana.com/mwfiles/thumbs/fit630x300/8496/1591226919/%D8%B7%D8%B1%D9%8A%D9%82%D8%A9_%D8%AA%D8%AD%D8%B6%D9%8A%D8%B1_%D8%A7%D9%84%D9%84%D8%A8%D9%86_%D8%A7%D9%84%D8%B1%D8%A7%D9%8A%D8%A8.jpg',
                                ),
                                Divider(
                                  height: s.height/50,
                                  thickness: 1,
                                ),
                                IngTile(
                                  width: s.width*0.88,
                                  height: 55.0,
                                  title: 'Almond',
                                  amount: '150 Grams',
                                  imageURL: 'https://cdn.mos.cms.futurecdn.net/oDh2aBTkP5md9yoQLW7js.jpg',
                                ),
                                Divider(
                                  height: s.height/50,
                                  thickness: 1,
                                ),
                                IngTile(
                                  width: s.width*0.88,
                                  height: 55.0,
                                  title: 'Saj Bread',
                                  amount: '2 Loaves',
                                  imageURL: 'https://www.tareekaa.com/wp-content/uploads/2019/01/%D8%AE%D8%A8%D8%B2-%D8%A7%D9%84%D8%B5%D8%A7%D8%AC-%D9%84%D9%84%D8%B4%D8%A7%D9%88%D8%B1%D9%85%D8%A7.jpg',
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}