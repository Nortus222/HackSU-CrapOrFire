import 'package:flutter/material.dart';
import 'package:new_app/models/menuItem.dart';
import 'package:new_app/models/rating.dart';

class globals {
  /*static List<Rating> globalArray = [
    Rating(MenuItem(0, "-1", "-1", ["-1"], DateTime.now()), 3, DateTime.now())
  ];
  static int globalIndex = 0;
  static void createRating(
      List<MenuItem> menuItems, int widgetID, int itemID, double rating) {
    var menuItem = menuItems.firstWhere((element) => element.id == itemID);
    globalArray[widgetID] = Rating(menuItem, rating, DateTime.now());
  }*/
}

class RatingWidget extends StatefulWidget {
  final List<MenuItem> menuItems;
  const RatingWidget({Key? key, required this.menuItems}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    //int widgetID = globals.globalIndex;
    int dropdownvalue = widget.menuItems[0].id;
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
                //globals.createRating(widget.menuItems, widgetID, dropdownvalue,
                //    _currentSliderValue + 1);
              });
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: Slider(
            activeColor: Colors.orange,
            inactiveColor: Colors.orange.shade200,
            value: _currentSliderValue,
            max: 4,
            divisions: 4,
            label: (_currentSliderValue.round() + 1).toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                //globals.createRating(widget.menuItems, widgetID, dropdownvalue,
                //    _currentSliderValue + 1);
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

  @override
  Widget build(BuildContext context) {
    //globals.globalArray.length = numOfItems - 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Your Eats"),
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
          child: ListView.builder(
              itemCount: numOfItems,
              itemBuilder: (BuildContext context, int index) {
                //globals.globalIndex = index;
                if (index + 2 == numOfItems) {
                  return Row(children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          numOfItems++;
                          //if (globals.globalArray.length < numOfItems - 2) {
                          //  globals.globalArray.length = numOfItems - 2;
                          //}
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade300,
                          padding:EdgeInsets.all(8.0),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Add Item'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (numOfItems > 3) {
                          setState(() {
                            numOfItems--;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade300,
                          padding:EdgeInsets.all(8.0),
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
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade300,
                          padding:EdgeInsets.all(8.0),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Submit'),
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
