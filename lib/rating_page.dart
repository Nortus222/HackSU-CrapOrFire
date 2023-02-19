import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/bloc/events/rating_event.dart';
import 'package:new_app/bloc/menuItem_bloc.dart';
import 'package:new_app/bloc/rating_bloc.dart';
import 'package:new_app/models/menuItem.dart';
import 'package:new_app/models/rating.dart';

import 'bloc/events/menuItem_event.dart';

class globals {
  static List<Rating> globalArray = [
    Rating(MenuItem(-1, "-1", "-1", ["-1"], DateTime.now()), 3, DateTime.now())
  ];
  static int globalIndex = 0;
  static void createRating(
      List<MenuItem> menuItems, int widgetID, int itemID, double rating) {
    var menuItem = menuItems.firstWhere((element) => element.id == itemID);
    globalArray[widgetID] = Rating(menuItem, rating, DateTime.now());
  }
}

class RatingWidget extends StatefulWidget {
  final List<MenuItem> menuItems;
  const RatingWidget({Key? key, required this.menuItems}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int dropdownvalue = 1;
  double _currentSliderValue = 2;
  int widgetID = globals.globalIndex;

  @override
  Widget build(BuildContext context) {
    var items = List<DropdownMenuItem<int>>.generate(
        widget.menuItems.length,
        (int index) => DropdownMenuItem(
            value: widget.menuItems[index].id,
            child: Text(widget.menuItems[index].title)));
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: DropdownButton(
            //Displayed Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            //Menu Items
            items: items,
            onChanged: (int? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                globals.createRating(widget.menuItems, widgetID, dropdownvalue,
                    _currentSliderValue + 1);
              });
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: Slider(
            value: _currentSliderValue,
            max: 4,
            divisions: 4,
            label: (_currentSliderValue.round() + 1).toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                globals.createRating(widget.menuItems, widgetID, dropdownvalue,
                    _currentSliderValue + 1);
              });
            },
          ),
        ),
      ],
    );
  }
}

class RatingPage extends StatefulWidget {
  final List<MenuItem> menuItems;
  const RatingPage({Key? key, required this.menuItems}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int numOfItems = 3;
  String submitText = "Submit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Was it Crap? Or Fire?"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
          child: ListView.builder(
              itemCount: numOfItems,
              itemBuilder: (BuildContext context, int index) {
                globals.globalIndex = index;
                if (index + 2 == numOfItems) {
                  return Row(children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          numOfItems++;
                          globals.globalArray.add(Rating(
                              MenuItem(-1, "-1", "-1", ["-1"], DateTime.now()),
                              3,
                              DateTime.now()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Add Item'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (numOfItems > 3) {
                          setState(() {
                            numOfItems--;
                            globals.globalArray.length--;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Remove Item'),
                    ),
                    const Spacer(),
                  ]);
                }
                if (index + 1 == numOfItems) {
                  return Row(children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<MenuItemBloc>()
                            .add(UploadRatings(globals.globalArray));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: Text(submitText),
                    ),
                    const Spacer(),
                  ]);
                }
                return RatingWidget(
                  menuItems: widget.menuItems,
                );
              }),
        ),
      ),
    );
  }
}
