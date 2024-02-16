import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/car/car_model.dart';
import '../car_main_screen/main_screen.dart';

class CarInfoAddViewModel extends ChangeNotifier {
  String? userUid;
  StreamSubscription? _streamSubscription;
  List<Map<String, dynamic>> _data = [];
  String getCompany = '';
  String getCarSelect = '';
  String getGasSelect = '';
  String getCheckType = '';
  int distance = 0;
  String getCarNumber = '';
  CarModel? selectedCarData;

  Map<String, String> settingType = {
    '변속기오일': 'missionOilLastDate',
    '엔진오일': 'engineOilLastDate',
    '브레이크오일': 'breakOilLastDate',
    '브레이크패드': 'breakPadLastDate',
    '파워스테어링오일': 'powerSteeringWheelLastDate',
    '디퍼런셜오일': 'differentialOilLastDate',
  };
  String selectedSettingType = '변속기오일';

  void changeSelectedSettingType(String type) {
    selectedSettingType = type;
    notifyListeners();
  }

  void setValue({
    String? companyString,
    String? carSelectString,
    String? gasSelectString,
    String? checkTypeString,
    int? dinstanceInt,
    String? carNumberString,
  }) {
    getCompany = companyString ?? getCompany;
    getCarSelect = carSelectString ?? getCarSelect;
    getGasSelect = gasSelectString ?? getGasSelect;
    getCheckType = checkTypeString ?? getCheckType;
    distance = dinstanceInt ?? distance;
    getCarNumber = carNumberString ?? getCarNumber;

    log('companyString: $companyString, carSelectString: $carSelectString,'
        'gasSelectString: $gasSelectString, checkTypeString: $checkTypeString'
        'dinstanceInt:$dinstanceInt carNumberString: $carNumberString');
  }

  Future<void> initializeUserInfoAndSubscribeToChanges(
      {CarModel? selectedCar}) async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userUid = user.id;

      subscribeToUserChanges(user.id);

      if (selectedCar != null) {
        selectedCarData = selectedCar;
        getCompany = selectedCar.company;
        getCarSelect = selectedCar.carName;
        getGasSelect = selectedCar.gasType;
        distance = selectedCar.distance;
        getCarNumber = selectedCar.carNumber;
      }
      notifyListeners();
    }
  }

  void subscribeToUserChanges(String userId) {
    _streamSubscription = supabase
        .from('CarPeriodicAdd')
        .stream(primaryKey: ['id'])
        .eq('uid', userId)
        .order('date', ascending: false)
        .listen((data) {
          _data = data;
          notifyListeners();
        }, onError: (error) {
          notifyListeners();
        });
  }

  Future<bool> validateAndSubmit() async {
    try {
      await supabase.from('CarPeriodicAdd').insert({
        'company': getCompany.trim() ?? '',
        'car_select': getCarSelect.trim() ?? '',
        'gas_select': getGasSelect.trim() ?? '',
        'check_type': selectedSettingType,
        'distance': distance ?? 0,
        'car_number': getCarNumber.trim() ?? '',
      });
      // 차량 최신 업데이트
      final user = supabase.auth.currentUser;
      Map<String, dynamic> data = {'id': user!.id};
      Map<String, dynamic> carInfo = {};
      if (selectedCarData != null) {
        // data.addAll(selectedCarData!.toJson());
        carInfo.addAll(CarModel(
          carNumber: getCarNumber,
          carName: getCarSelect,
          company: getCompany,
          gasType: getGasSelect,
          distance: distance,
          missionOilLastDate: selectedCarData?.missionOilLastDate,
          engineOilLastDate: selectedCarData?.engineOilLastDate,
          breakOilLastDate: selectedCarData?.breakOilLastDate,
          breakPadLastDate: selectedCarData?.breakPadLastDate,
          powerSteeringWheelLastDate: selectedCarData?.powerSteeringWheelLastDate,
          differentialOilLastDate: selectedCarData?.differentialOilLastDate,
        ).toJson());
      } else {
        carInfo.addAll(CarModel(
          carNumber: getCarNumber,
          carName: getCarSelect,
          company: getCompany,
          gasType: getGasSelect,
          distance: distance,
        ).toJson());
        notifyListeners();
      }

      data.addAll(carInfo);
      String? type = settingType[selectedSettingType];
      if (type != null) {
        data.addAll({
          type: DateFormat('yy/MM/dd - HH:mm').format(DateTime.now()).toString()
        });
      }

      await supabase.from('CarList').update(data).eq("carNumber", getCarNumber);

      log('message ${data.toString()}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertCar() async {
    final user = supabase.auth.currentUser;
    Map<String, dynamic> data = {'id': user!.id};
    try {
      Map<String, dynamic> carInfo = CarModel(
        carNumber: getCarNumber,
        carName: getCarSelect,
        company: getCompany,
        gasType: getGasSelect,
        distance: distance,
      ).toJson();
      data.addAll(carInfo);
      String? type = settingType[selectedSettingType];
      if (type != null) {
        data.addAll({type: DateTime.now().toString()});
      }
      log('message ${data.toString()}');
      await supabase.from('CarList').upsert(data).eq("carNumber", getCarNumber);
      notifyListeners();
      return true;
    } catch (e) {

      return false;
      notifyListeners();
    }

  }

}
