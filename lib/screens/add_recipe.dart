import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes/models/classes.dart';
import '../functions/functions.dart';
import 'package:recipes/components/components.dart';

List<Ingredient> ingredientsArr = [];

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {


  var descriptionCont = TextEditingController();
  var IngSearchCont = TextEditingController();
  var categoryCont = TextEditingController();
  var amountCont = TextEditingController();
  var nameCont = TextEditingController();
  var idCont = TextEditingController();
  FocusNode focusNodeDrop = FocusNode();
  int stackIndex = 0;
  String dropdownValue = 'Kilogram';
  var _count = 0;

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

  String personalImageURL = '',cardImageURL = '';
  final picker = ImagePicker();
  var _recipeImage;
  Future takePersonalPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.values[0]);
    setState(() {
      _recipeImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child:
              IndexedStack(
                sizing: StackFit.passthrough,
                index: stackIndex,
                key: ValueKey<int>(_count),
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        CircularAvatar(screenHeight / 11, _recipeImage),
                        TextField(
                          controller: nameCont,
                          textInputAction: TextInputAction.next,
                          //autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Name",
                          ),
                        ),
                        TextField(
                          controller: descriptionCont,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Description",
                          ),
                        ),
                        TextField(
                          controller: categoryCont,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Category",
                          ),
                        ),
                        TextField(
                          controller: idCont,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "ID",
                          ),
                          onTap: () {
                            print(MediaQuery.of(context).viewInsets.bottom);
                          },
                        ),
                        OutlinedButton(
                            key: Key("Add Ingredients Btn"),
                            onPressed: ()async {
                              setState(()  {
                                stackIndex = 1;
                                _count++;
                              });
                            },
                            child: Text('Add Ingredients')),
                        ElevatedButton(
                            onPressed: () => addRecipe(context, nameCont.text, descriptionCont.text,
                                categoryCont.text, idCont.text, ingredientsArr, _recipeImage),
                            child: Text("Add Recipe")),
                      ]),

                  Stack(
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 6,
                              runSpacing: -8,
                              children: ingredientsArr
                                  .map((item) => IngChip(
                                  setState,
                                  "https://cdn.loveandlemons.com/wp-content/uploads/2020/03/how-to-cook-rice.jpg",
                                  item.name,
                                  item.amount.toString(),
                                  item.unit))
                                  .toList()
                                  .cast<Widget>(),
                              //
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: TextField(
                                      controller: IngSearchCont,
                                      textInputAction: TextInputAction.next,
                                      key: Key("Ingredient Name Field"),
                                      decoration: InputDecoration(
                                        hintText: 'Ingredient Name',
                                      ),
                                      onTap: () => print(MediaQuery.of(context).viewInsets.bottom),
                                    ),
                                  ),
                                  Spacer(flex: 1),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      controller: amountCont,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      key: Key('Amount Field'),
                                      decoration: InputDecoration(
                                        hintText: 'Amount',
                                      ),
                                    ),
                                  ),
                                  Spacer(flex: 1),
                                  Expanded(
                                    flex: 8,
                                    child: DropdownButton<String>(
                                      focusColor: Colors.white,
                                      value: dropdownValue,
                                      //elevation: 5,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor: Colors.black,
                                      items: units.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(
                                        dropdownValue,
                                        style:
                                        TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    key: Key("Cancel Btn"),
                                    onPressed: () {
                                      print("0");
                                      setState(() {
                                        IngSearchCont.clear();
                                        amountCont.clear();
                                        dropdownValue = 'Kilogram';
                                        ingredientsArr.clear();
                                        stackIndex = 0;
                                        print("1");
                                      });
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                    child: Text('Cancel')
                                ),
                                OutlinedButton(
                                    key: Key("Add Ingredients Btn"),
                                    onPressed: () {
                                      setState(() {
                                        addIng(
                                          context,
                                          IngSearchCont.text,
                                          double.parse(amountCont.text.toString()).toDouble(),
                                          dropdownValue.toString(),
                                        );
                                        print(ingredientsArr);
                                        IngSearchCont.clear();
                                        amountCont.clear();
                                        dropdownValue = 'Kilogram';
                                      });
                                    },
                                    child: Text('Add Ingredient')
                                ),
                                OutlinedButton(
                                    key: Key("Done Btn"),
                                    onPressed: () {
                                      print("0");
                                      setState(() {
                                        stackIndex = 0;
                                        print("1");
                                      });
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                    child: Text('Done')
                                ),
                              ],
                            ),
                          ]
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


