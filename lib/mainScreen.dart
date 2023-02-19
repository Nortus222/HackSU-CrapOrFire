import 'package:flutter/material.dart';
import 'package:new_app/models/menuItem.dart';

class MainScreen extends StatelessWidget {
  //Assume Size of list is 10
  final List<MenuItem> menuItems;

  const MainScreen(this.menuItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [...getSlivers(menuItems)],
    );
  }
}

List<Widget> getSlivers(List<MenuItem> items) {
  List<Widget> slivers = [];

  for (var element in items) {
    slivers.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(element.title),
          trailing: Text((element.avgRating ?? "N/A").toString()),
          subtitle: Text(element.siteServed),
          tileColor: items.indexOf(element) < 5
              ? Colors.green.shade300
              : Colors.orange.shade300,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
