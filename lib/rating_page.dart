import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  String dropdownvalue = 'Item 2';
  double _currentSliderValue = 2;
  var items = [
    'Small Item',
    'Item 2',
    'Item 3',
    'Massive Huge Crazy Item Wow',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
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
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
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

class _RatingPageState extends State<RatingPage> {
  int numOfItems = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
                return const RatingWidget();
              }),
        ),
      ),
    );
  }
}
