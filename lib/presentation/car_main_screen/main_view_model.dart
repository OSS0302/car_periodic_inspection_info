import 'dart:async';

import 'package:car_periodic_inspection_info/data/repository/hyundi_mock_repositoryimpl.dart';
import 'package:car_periodic_inspection_info/domain/repository/car_periodic_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainViewModel extends ChangeNotifier {
  String? userUid;
  bool _isLoading = true;
  bool? isChecked = false;
  bool isComplete = false;
  final supabase = Supabase.instance.client;
  StreamSubscription? _streamSubscription;
  CarPeriodicRepository _repository;
  List<Map<String, dynamic>> _data = [];

  bool get isLoading => _isLoading;

  MainViewModel({
    required CarPeriodicRepository repository,
  }) : _repository = repository;


  Future<void> fetchMainInfoData() async {
    _isLoading = true;
    notifyListeners();
    await _repository.getCarInfo;
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void initState() {
    initializeUserInfoAndSubscribeToChanges();
    notifyListeners();
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
        .from('car_periodic_add')
        .stream(primaryKey: ['id'])
        .eq('uid', userId)
        .order('date', ascending: false)
        .listen((data) {

        _data = data;
        _isLoading = false;
        notifyListeners();
    }, onError: (error) {

        _isLoading = false;
        notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
