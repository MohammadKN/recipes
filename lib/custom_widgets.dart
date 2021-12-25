import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'functions.dart';
import 'main.dart';

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

FocusNode focusNodeDrop = FocusNode();
int stackIndex = 0;
String dropdownValue = 'Kilogram';
void showBottomSheet(BuildContext context) => showModalBottomSheet(
    //enableDrag: true,
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    builder: (_) {
      return StatefulBuilder(builder: (BuildContext ctx, StateSetter setModalState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IndexedStack(
                sizing: StackFit.passthrough,
                index: stackIndex,
                children: [
                  Column(mainAxisSize: MainAxisSize.min,
                      children: [
                    TextField(
                      controller: nameCont,
                      textInputAction: TextInputAction.next,
                      //autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                      onTap: () {},
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
                        onPressed: () {
                          if (nameCont.text.isNotEmpty && descriptionCont.text.isNotEmpty
                              && categoryCont.text.isNotEmpty && idCont.text.isNotEmpty){
                            setModalState(() => stackIndex = 1);
                          }
                          else {
                            Fluttertoast.showToast(
                                msg: "Fill The Fields Above To Add Ingredients",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.white70,
                                textColor: Colors.black54,
                                fontSize: 18.0);
                          }
                        },
                        child: Text('Add Ingredients')),
                    ElevatedButton(
                        onPressed: () => addRecipe(context, nameCont.text, descriptionCont.text,
                            categoryCont.text, idCont.text, ingredientsArr),
                        child: Text("Add Recipe")),
                  ]),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 6,
                      runSpacing: -8,
                      children: ingredientsArr
                          .map((item) => IngChip(
                              setModalState,
                              "https://cdn.loveandlemons.com/wp-content/uploads/2020/03/how-to-cook-rice.jpg",
                              item.name,
                              item.amount.toString(),
                              item.unit))
                          .toList()
                          .cast<Widget>(),
                      //
                    ),
                    Container(
                      width: MediaQuery.of(ctx).size.width,
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
                                setModalState(() {
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
                              setModalState(() {
                                stackIndex = 0;
                                print("1");
                              });
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            child: Text('Cancel')),
                        OutlinedButton(
                            key: Key("Add Ingredients Btn"),
                            onPressed: () {
                              setModalState(() {
                                addIng(
                                    ctx,
                                    IngSearchCont.text,
                                    double.parse(amountCont.text.toString()).toDouble(),
                                    dropdownValue.toString(),
                                    idCont.text
                                );
                                IngSearchCont.clear();
                                amountCont.clear();
                                dropdownValue = 'Kilogram';
                              });
                            },
                            child: Text('Add Ingredient')),
                      ],
                    ),
                  ]),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                child: Container(color: Colors.red,),
              ),
            ],
          ),
        );
      });
    });

Widget IngChip(StateSetter setModalState, String imagePath, String content, String amount, String unit) {
  return GestureDetector(
    onLongPress: () => setModalState(() => deleteIng(content)),
    child: Chip(
      avatar: CircleAvatar(
        foregroundImage: NetworkImage(imagePath),
        foregroundColor: Colors.blueAccent,
      ),
      label: Text(content),
      backgroundColor: Colors.grey[300],
    ),
  );
}
