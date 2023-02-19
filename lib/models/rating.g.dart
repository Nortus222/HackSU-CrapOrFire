// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
      (json['rating'] as num).toDouble(),
      DateTime.parse(json['timeSubmitted'] as String),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'menuItem': instance.menuItem,
      'rating': instance.rating,
      'timeSubmitted': instance.timeSubmitted.toIso8601String(),
    };
