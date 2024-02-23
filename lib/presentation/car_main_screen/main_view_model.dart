import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/model/car/car_model.dart';

class MainViewModel extends ChangeNotifier {
  String? userUid;
  bool _isLoading = true;
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _data = [];

  // 사용자의 차량 리스트
  List<CarModel> userCarList = [];
  CarModel? selectedCar;
  String userName = '';

  bool get isLoading => _isLoading;

  Future<void> getReady() async {
    await initializeUserInfoAndSubscribeToChanges();
  }

  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userUid = user.id;

      await getInfo(user.id);
      await loginSupabase();
      notifyListeners();
    }
  }

  Future<String?> loginSupabase() async {
    final data = await supabase
        .from('user_info')
        .select('name, phone')
        .eq('id', supabase.auth.currentUser!.id);

    String name = '';
    if (data.isNotEmpty) {
      name = '${data[0]['name']}(${data[0]['phone']})';
    }

    userName = name;
  }

  // 날짜 보이게 하는 영역
  Future<void> getInfo(String userId) async {
    userCarList = [];
    final data = await supabase
        .from('CarList')
        .select(
        'carNumber, carName, company, gasType, distance, engineOilLastDate, missionOilLastDate, breakOilLastDate, breakPadLastDate, powerSteeringWheelLastDate, differentialOilLastDate')
        .eq('id', userId);

    if (data.isNotEmpty) {
      data.forEach((e) {
        userCarList.add(CarModel(
          carNumber: e['carNumber'],
          carName: e['carName'],
          company: e['company'],
          gasType: e['gasType'],
          distance: e['distance'],
          engineOilLastDate: e['engineOilLastDate'],
          missionOilLastDate: e['missionOilLastDate'],
          breakOilLastDate: e['breakOilLastDate'],
          breakPadLastDate: e['breakPadLastDate'],
          powerSteeringWheelLastDate: e['powerSteeringWheelLastDate'],
          differentialOilLastDate: e['differentialOilLastDate'],
        ));
      });
      if (selectedCar != null) {
        selectedCar = userCarList.firstWhere(
                (element) => element.carNumber == selectedCar!.carNumber);
      } else {
        selectedCar = userCarList[0];
      }
    }
    notifyListeners();
  }

  void changeSelectCar(String value) {
    final selected =
    userCarList.firstWhere((element) => element.carNumber == value);
    selectedCar = selected;
    notifyListeners();
  }

}
