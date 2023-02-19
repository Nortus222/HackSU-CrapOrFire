import 'package:json_annotation/json_annotation.dart';

part 'menuItem.g.dart';

@JsonSerializable()
class MenuItem {
  int id;
  String title;
  String siteServed;
  List<String> timeServed;
  DateTime dateServed;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? avgRating;

  MenuItem(
      this.id, this.title, this.siteServed, this.timeServed, this.dateServed,
      {this.avgRating});

  factory MenuItem.fromJson(Map<String, dynamic> data) =>
      _$MenuItemFromJson(data);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
