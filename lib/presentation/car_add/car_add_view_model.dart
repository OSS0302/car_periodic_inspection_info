import 'dart:async';
import 'package:car_periodic_inspection_info/domain/model/car/car_model.dart';
import 'package:flutter/material.dart';
import '../car_info_add_screen/car_info_add_screen.dart';

class CarAddViewModel extends ChangeNotifier {
  String? userUid;
  StreamSubscription? _streamSubscription;
  List<Map<String, dynamic>> _data = [];
  String getCompany = '';
  String getCarSelect = '';
  String getGasSelect = '';
  int distance = 0;
  String getCarNumber = '';

  void setValue({
    String? companyString,
    String? carSelectString,
    String? gasSelectString,
    int? dinstanceInt,
    String? carNumberString,
  }) {
    getCompany = companyString ?? getCompany;
    getCarSelect = carSelectString ?? getCarSelect;
    getGasSelect = gasSelectString ?? getGasSelect;
    distance = dinstanceInt ?? distance;
    getCarNumber = carNumberString ?? getCarNumber;
  }

  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userUid = user.id;

      await subscribeToUserChanges(user.id);
      notifyListeners();
    }
  }

  Future<void> subscribeToUserChanges(String userId) async {
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
      await supabase.from('CarList').upsert(data).eq("carNumber", '1111');
      return true;
    } catch (e) {
      return false;
    }
  }
}
