// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menuItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      json['id'] as int,
      json['title'] as String,
      json['siteServed'] as String,
      (json['timeServed'] as List<dynamic>).map((e) => e as String).toList(),
      DateTime.parse(json['dateServed'] as String),
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'siteServed': instance.siteServed,
      'timeServed': instance.timeServed,
      'dateServed': instance.dateServed.toIso8601String(),
    };
