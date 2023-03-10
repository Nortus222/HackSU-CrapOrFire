import 'package:json_annotation/json_annotation.dart';
import 'package:new_app/models/menuItem.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  MenuItem menuItem;
  double rating;
  DateTime timeSubmitted;

  Rating(this.menuItem, this.rating, this.timeSubmitted);

  factory Rating.fromJson(Map<String, dynamic> data) => _$RatingFromJson(data);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
