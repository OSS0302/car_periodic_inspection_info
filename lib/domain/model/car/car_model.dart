import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'car_model.freezed.dart';

part 'car_model.g.dart';

@freezed
class CarModel with _$CarModel {
  const factory CarModel({
    required String carNumber,
    required String carName,
    required String company,
    required String gasType,
    required int distance,
    String? engineOilLastDate,
    String? missionOilLastDate,
    String? breakOilLastDate,
    String? breakPadLastDate,
    String? powerSteeringWheelLastDate,
    String? differentialOil,

  }) = _CarModel;

  factory CarModel.fromJson(Map<String, Object?> json) => _$CarModelFromJson(json);
}