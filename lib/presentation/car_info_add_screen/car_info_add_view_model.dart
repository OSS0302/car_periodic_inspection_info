import 'package:car_periodic_inspection_info/domain/repository/car_periodic_repository.dart';
import 'package:flutter/material.dart';

class CarInfoAddViewModel extends ChangeNotifier {
  final CarPeriodicRepository _repository;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

   CarInfoAddViewModel({
    required CarPeriodicRepository repository,
  }) : _repository = repository;

   Future<void> fetchGetData() async {
     _isLoading  = true;
    notifyListeners();
    await _repository.getCarInfo;
      _isLoading = false;
      notifyListeners();
   }


}