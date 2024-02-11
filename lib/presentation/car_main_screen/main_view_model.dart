import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainViewModel extends ChangeNotifier {
  String? userUid;
  bool _isLoading = true;
  final supabase = Supabase.instance.client;
  StreamSubscription? _streamSubscription;
  List<Map<String, dynamic>> _data = [];

  bool get isLoading => _isLoading;

  Future<void> getReady() async {
    initializeUserInfoAndSubscribeToChanges();
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
        _isLoading = false;
        notifyListeners();
    }, onError: (error) {

        _isLoading = false;
        notifyListeners();
    });
  }

}
