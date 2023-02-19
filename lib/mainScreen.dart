import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_app/models/menuItem.dart';

class MainScreen extends StatelessWidget {
  //Assume Size of list is 10
  final List<MenuItem> menuItems;

  const MainScreen(this.menuItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: getSlivers(menuItems),
    );
  }
}

List<Widget> getSlivers(List<MenuItem> items) {
  List<Widget> slivers = [];

  for (var element in items) {
    slivers.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          borderOnForeground: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.hardEdge,
          elevation: 3,
          child: ListTile(
            title: Text(
              element.title,
              style: const TextStyle(fontSize: 20),
            ),
            trailing: Container(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${(element.avgRating == null ? "N/A" : element.avgRating!.toStringAsPrecision(2))} ",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  items.indexOf(element) < 5
                      ? const FaIcon(FontAwesomeIcons.fire)
                      : const FaIcon(FontAwesomeIcons.poo),
                ],
              ),
            ),
            subtitle: Text(
              element.siteServed,
              style: const TextStyle(fontSize: 18),
            ),
            tileColor: items.indexOf(element) < 5
                ? Colors.green.shade300
                : Colors.orange.shade300,
          ),
        ),
      ),
    ));
  }

  slivers.insert(
      0,
      const SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Fire",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      )));
  slivers.insert(
      6,
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Crap",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ));

  return slivers;
}
