import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
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

  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userUid = user.id;

      subscribeToUserChanges(user.id);
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
        'check_type': getCheckType.trim() ?? '',
        'distance': distance ?? 0,
        'car_number': getCarNumber.trim() ?? '',
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
