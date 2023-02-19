import 'package:flutter/material.dart';
import 'package:new_app/models/menuItem.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("RatingPage"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
          child: ListView.builder(
              itemCount: numOfItems,
              itemBuilder: (BuildContext context, int index) {
                if (index + 2 == numOfItems) {
                  return Row(children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          numOfItems++;
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
                        setState(() {
                          //TODO
                        });
                      },
                      style: ElevatedButton.styleFrom(
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
