import 'package:cloud_firestore/cloud_firestore.dart';
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
    return (await ratings.get())
        .docs
        .map((item) => Rating.fromJson(item.data()))
        .toList();
  }

  static Future updateRating(Rating rating) async {
    return await ratings.add(rating.toJson());
  }

  static Future updateRatings(List<Rating> ratings) async {
    ratings.forEach((element) async {
      await Database.updateRating(element);
    });
  }
}
