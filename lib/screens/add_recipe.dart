import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes/models/classes.dart';
import '../functions/functions.dart';
import 'package:recipes/components/components.dart';

List<Ingredient> ingredientsArr = [];

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  AddRecipePageState createState() => AddRecipePageState();
}

class AddRecipePageState extends State<AddRecipePage> {


  var descriptionCont = TextEditingController();
  var ingSearchCont = TextEditingController();
  var categoryCont = TextEditingController();
  var amountCont = TextEditingController();
  var nameCont = TextEditingController();
  var idCont = TextEditingController();
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
    'Gram',
    'Piece',
  ];

  void stackChanger (int target){
    setState(()  {
      stackIndex = 1;
      _count++;
    });
  }

  String personalImageURL = '',cardImageURL = '';
  final picker = ImagePicker();
  var recipeImage;
  Future takePersonalPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.values[0]);
    setState(() {
      recipeImage = File(pickedFile!.path);
    });
  }
  Future pickPersonalPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.values[1]);
    setState(() {
      recipeImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (recipeImage != null)
                GestureDetector(
                  onTap: () async {
                    showMyDialog(context);
                  },
                  child: CircleAvatar(
                    radius: screenHeight/11,
                    backgroundImage: FileImage(recipeImage),
                  ),
                ),
              if (recipeImage == null)
                GestureDetector(
                  onTap: () async {
                    showMyDialog(context);
                  },
                  child: CircleAvatar(
                    radius: screenHeight/11,
                    backgroundImage: const NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/bus-jo.appspot.com/o/Assets%2FAnonymous.png?alt=media&token=fccfa75f-20f1-43b3-9a5f-6efc705fabc5'),
                  ),
                ),


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

                    const AddRecipeForm(),

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
                                    setModalState : setState,
                                    imagePath: 'https://cdn.loveandlemons.com/wp-content/uploads/2020/03/how-to-cook-rice.jpg',
                                    content: item.name,
                                    amount: item.amount.toString(),
                                    unit: item.unit))
                                    .toList()
                                    .cast<Widget>(),
                                //
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: TextField(
                                        controller: ingSearchCont,
                                        textInputAction: TextInputAction.next,
                                        key: const Key('Ingredient Name Field'),
                                        decoration: const InputDecoration(
                                          hintText: 'Ingredient Name',
                                        ),
                                        onTap: () {
                                          if (kDebugMode) {
                                            print(MediaQuery
                                              .of(context)
                                              .viewInsets
                                              .bottom);
                                          }
                                        },
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                    Expanded(
                                      flex: 5,
                                      child: TextField(
                                        controller: amountCont,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        key: const Key('Amount Field'),
                                        decoration: const InputDecoration(
                                          hintText: 'Amount',
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                    Expanded(
                                      flex: 8,
                                      child: DropdownButton<String>(
                                        focusColor: Colors.white,
                                        value: dropdownValue,
                                        //elevation: 5,
                                        style: const TextStyle(color: Colors.white),
                                        iconEnabledColor: Colors.black,
                                        items: units.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          dropdownValue,
                                          style:
                                          const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
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
                                      key: const Key('Cancel Btn'),
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print('0');
                                        }
                                        setState(() {
                                          ingSearchCont.clear();
                                          amountCont.clear();
                                          dropdownValue = 'Kilogram';
                                          ingredientsArr.clear();
                                          stackIndex = 0;
                                          if (kDebugMode) {
                                            print('1');
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all(Colors.red),
                                      ),
                                      child: const Text('Cancel')
                                  ),
                                  OutlinedButton(
                                      key: const Key('Add Ingredients Btn'),
                                      onPressed: () {
                                        setState(() {
                                          addIng(
                                            context,
                                            ingSearchCont.text,
                                            double.parse(amountCont.text.toString()).toDouble(),
                                            dropdownValue.toString(),
                                          );
                                          if (kDebugMode) {
                                            print(ingredientsArr);
                                          }
                                          ingSearchCont.clear();
                                          amountCont.clear();
                                          dropdownValue = 'Kilogram';
                                        });
                                      },
                                      child: const Text('Add Ingredient')
                                  ),
                                  OutlinedButton(
                                      key: const Key('Done Btn'),
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print('0');
                                        }
                                        setState(() {
                                          stackIndex = 0;
                                          if (kDebugMode) {
                                            print('1');
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all(Colors.red),
                                      ),
                                      child: const Text('Done')
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
      ),
    );
  }
}


