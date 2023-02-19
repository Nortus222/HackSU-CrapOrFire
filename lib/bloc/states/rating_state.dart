import 'package:new_app/models/rating.dart';

class RatingState {}

class RatingSuccessState extends RatingState {
  final List<Rating> ratings;

  RatingSuccessState(this.ratings);
}

class RatingLoadingstate extends RatingState {}

class RatingFailureState extends RatingState {}
