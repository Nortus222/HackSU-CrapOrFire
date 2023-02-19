import 'package:new_app/models/rating.dart';

class RatingEvent {}

class UploadRating extends RatingEvent {
  final List<Rating> ratings;

  UploadRating(this.ratings);
}

class GetRatings extends RatingEvent {}
