import 'package:json_annotation/json_annotation.dart';

part 'menuItem.g.dart';

@JsonSerializable()
class MenuItem {
  String title;
  String siteServed;
  List<String> timeSreved;
  DateTime dateServed;

  MenuItem(this.title, this.siteServed, this.timeSreved, this.dateServed);

  factory MenuItem.fromJson(Map<String, dynamic> data) =>
      _$MenuItemFromJson(data);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
