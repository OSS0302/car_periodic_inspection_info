// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarModelImpl _$$CarModelImplFromJson(Map<String, dynamic> json) =>
    _$CarModelImpl(
      carNumber: json['carNumber'] as String,
      carName: json['carName'] as String,
      company: json['company'] as String,
      gasType: json['gasType'] as String,
      distance: json['distance'] as int,
      engineOilLastDate: json['engineOilLastDate'] as String?,
      missionOilLastDate: json['missionOilLastDate'] as String?,
      breakOilLastDate: json['breakOilLastDate'] as String?,
      breakPadLastDate: json['breakPadLastDate'] as String?,
      powerSteeringWheelLastDate: json['powerSteeringWheelLastDate'] as String?,
      differentialOilLastDate: json['differentialOilLastDate'] as String?,
    );

Map<String, dynamic> _$$CarModelImplToJson(_$CarModelImpl instance) =>
    <String, dynamic>{
      'carNumber': instance.carNumber,
      'carName': instance.carName,
      'company': instance.company,
      'gasType': instance.gasType,
      'distance': instance.distance,
      'engineOilLastDate': instance.engineOilLastDate,
      'missionOilLastDate': instance.missionOilLastDate,
      'breakOilLastDate': instance.breakOilLastDate,
      'breakPadLastDate': instance.breakPadLastDate,
      'powerSteeringWheelLastDate': instance.powerSteeringWheelLastDate,
      'differentialOilLastDate': instance.differentialOilLastDate,
    };
