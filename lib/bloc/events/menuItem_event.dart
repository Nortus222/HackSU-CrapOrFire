import 'package:new_app/models/rating.dart';

class MenuItemEvent {}

class GetMenuItems extends MenuItemEvent {}

class GetMenuItemsWithRating extends MenuItemEvent {}

class UploadRatings extends MenuItemEvent {
  final List<Rating> ratings;

  UploadRatings(this.ratings);
}
