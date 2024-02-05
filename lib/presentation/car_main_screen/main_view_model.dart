import 'package:car_periodic_inspection_info/data/repository/hyundi_mock_repositoryimpl.dart';
import 'package:car_periodic_inspection_info/domain/repository/car_periodic_repository.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool? isChecked = false;
  CarPeriodicRepository _repository;

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
}
