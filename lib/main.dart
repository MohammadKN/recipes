import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' ;
import 'widgets/custom_widgets.dart';
import 'package:hive/hive.dart';
import 'model/recipe.dart';
import 'functions.dart';


var descriptionCont = TextEditingController();
var IngSearchCont = TextEditingController();
var amountCont = TextEditingController();
var unitCont = TextEditingController();
var categoryCont = TextEditingController();
var nameCont = TextEditingController();
var idCont = TextEditingController();
List<String> units = ['Cup', 'TableSpoon', 'Spoon', 'Liter', 'Pinch',
                        'MilliLiter', 'Packet', 'Kilogram','Gram'];
List recipesArr = [];
List<Ingredient> ingredientsArr = [];
late Box RecipesBox;
late Box IngBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(RecipeAdapter());
  IngBox = await Hive.openBox<Ingredient>('ingredients');
  RecipesBox = await Hive.openBox<Recipe>('recipes');
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
  void onRecipeAdded (){
    setState(()=>addRecipe(context, nameCont.text, descriptionCont.text, categoryCont.text,
        idCont.text, ingredientsArr));
  }
  @override
  Widget build(BuildContext context) {
    print('HomePage rebuilt');
    var sw = MediaQuery.of(context).size.width;
    var sh = MediaQuery.of(context).size.height;
    ingredientsArr.add(Ingredient(name: "rice", amount: 1, unit: "cup"));
    //if (ingredientsArr[0].name.isEmpty)
    //  ingredientsArr[0] = Ingredient(name: "rice", amount: 1, unit: "cup", physicalState: PhysicalState.powder);
    if (RecipesBox.values.isNotEmpty) {
      recipesArr = RecipesBox.values.toList();
      ingredientsArr = IngBox.values.toList().cast<Ingredient> ();
      print('Recipes got updated');
    }
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
        body: Container(
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
                            initialItemCount: recipesArr.length,
                            itemBuilder: (BuildContext context, i, animation) {
                              return SlideTransition(
                                position: animation.drive(Tween(begin: Offset(1.0,0.0),end: Offset.zero)),
                                child: GestureDetector(
                                    onLongPress: () async{
                                      setState(() {
                                        deleteRecipe(context, i);
                                      });
                                    },
                                    child: homePageTile(customText(0, 0, recipesArr[i].name, Colors.white, 18, FontWeight.bold)
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
          )
        )
    );
  }
}
