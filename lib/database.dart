import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:new_app/models/menuItem.dart';
import 'package:new_app/models/rating.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> menuItems =
    _firestore.collection('menuItems');
final CollectionReference<Map<String, dynamic>> ratings =
    _firestore.collection('ratings');

class Database {
  static Future<List<MenuItem>> getMenuItems() async {
    return (await menuItems.get())
        .docs
        .map((item) => MenuItem.fromJson(item.data()))
        .toList();
  }

  static Future<List<Rating>> getRatings() async {
    List<Rating> ratingsList = [];

    var ratingsmap = (await ratings.get()).docs;

    for (var e in ratingsmap) {
      var mp = e.data();
      var item = await ((mp['menuItem'] as DocumentReference).get());
      mp['menuItem'] = item.data();

      ratingsList.add(Rating.fromJson(mp));
    }

    return ratingsList;
  }

  static Future updateRating(Rating rating) async {
    var item = rating.menuItem;

    var ref = await menuItems.where('id', isEqualTo: rating.menuItem.id).get();

    var json = rating.toJson();

    json['menuItem'] = ref.docs.first.reference;

    print(json);

    return await ratings.add(json);
  }

  static Future updateRatings(List<Rating> ratings) async {
    await Database.updateRating(ratings.first);
    // ratings.forEach((element) async {
    //   await Database.updateRating(element);
    // });
  }

  static Future uploadFromFile() async {
    final String json = await rootBundle.loadString("data.txt");

    Map<String, dynamic> data = jsonDecode(json);

    data.forEach((key, value) async {
      // await menuItems.add(value);
    });
  }
}
