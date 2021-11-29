import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../functions.dart';
import '../../main.dart';

Widget customText(double HorPad, double VerPad, String content, Color color, double size, FontWeight weight) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: HorPad, vertical: VerPad),
    child: Text(
      "$content",
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    ),
  );
}

Widget homePageTile(Widget title) {
  return Container(
    height: 150,
    width: 150,
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(25),
    ),
    alignment: Alignment.bottomRight,
    child: Padding(padding: EdgeInsets.all(10), child: title),
  );
}

Widget AddIngField() {
  return TextField(
    key: ValueKey(2),
    decoration: InputDecoration(hintText: 'Add Ingredients'),
  );
}

bool addingIng = false;
bool _Field = false;
Color _clearBtnColor = Colors.black26;
void showBottomSheet(BuildContext context) => showModalBottomSheet(
    //enableDrag: true,
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    builder: (_) {
      return StatefulBuilder(builder: (BuildContext ctx, StateSetter setModalState) {
        var dropdownValue;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (addingIng == false)
                TextField(
                  controller: nameCont,
                  textInputAction: TextInputAction.next,
                  //autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                  onTap: () {},
                ),
              if (addingIng == false)
                TextField(
                  controller: descriptionCont,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Subtitle",
                  ),
                ),
              if (addingIng == false)
                TextField(
                  controller: categoryCont,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Category",
                  ),
                ),
              if (addingIng == false)
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
              if (addingIng == false)
                OutlinedButton(
                  key: Key("Add Ingredients Btn"),
                  onPressed: () {
                    print("0");
                    setModalState(() {
                      _Field = true;
                      addingIng = true;
                      print("1");
                    });
                  },
                  child: Text('Add Ingredients')),
              if (addingIng == true)
                Container(
                  width: MediaQuery.of(ctx).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextField(
                          controller: IngSearchCont,
                          textInputAction: TextInputAction.next,
                          key: Key("Ingredient Name Field"),
                          decoration: InputDecoration(
                            hintText: 'Ingredient Name',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setModalState(() {
                                  _Field = false;
                                  addingIng = false;
                                  IngSearchCont.clear();
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: _clearBtnColor,
                              ),
                            ),
                          ),
                          onEditingComplete: () {
                            setModalState(() {
                              var s = 5;
                            });
                          },
                        ),
                      ),
                      Spacer(flex: 2),
                      Expanded(
                        flex: 10,
                        child: TextField(
                          controller: amountCont,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          key: Key('Amount Field'),
                          decoration: InputDecoration(
                            hintText: 'Amount Field',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setModalState(() {
                                  _Field = false;
                                  addingIng = false;
                                  IngSearchCont.clear();
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: _clearBtnColor,
                              ),
                            ),
                          ),
                          onTap: () => addingIng = true,
                          onEditingComplete: () {
                            setModalState(() {
                              var s = 5;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (addingIng == true)
                DropdownButton<String>(
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
                    dropdownValue??"unit",
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String? value) {
                    setModalState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              if (_Field == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        key: Key("Cancel Btn"),
                        onPressed: () {
                          print("0");
                          setModalState(() {
                            _Field = false;
                            addingIng = false;
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
                          print("0");
                          setModalState(() {
                            addIng(ctx, IngSearchCont.text, int.parse(amountCont.text.toString()).toDouble(), dropdownValue.toString());
                            print("1");
                          });
                        },
                        child: Text('Add Ingredients')
                    ),
                  ],
                ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: [
                  // IngChip(setModalState, IngSearchCont.text, amountCont.text, dropdownValue.toString()),
                ],
              ),
              if (addingIng == false)
                ElevatedButton(
                    onPressed: () => addRecipe(context, nameCont.text, descriptionCont.text,
                        categoryCont.text, idCont.text, ingredientsArr),
                    child: Text("Add Recipe")),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                child: Container(),
              ),
            ],
          ),
        );
      });
    });

Widget IngChip(StateSetter setModalState, String content, String amount, String unit) {
  return GestureDetector(
    child: Chip(
      avatar: CircleAvatar(
        foregroundColor: Colors.blueAccent,
        child: Text(content.characters.first),
      ),
      label: Text(content),
      backgroundColor: Colors.grey[300],
    ),
  );
}
