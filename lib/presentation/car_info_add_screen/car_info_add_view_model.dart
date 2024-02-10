import 'package:go_router/go_router.dart';
import 'package:car_periodic_inspection_info/domain/repository/car_periodic_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'car_info_add_screen.dart';

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
  final stream = supabase.from('user_info').stream(primaryKey: ['id']);
  final _formKey = GlobalKey<FormState>();

  TextEditingController companyController = TextEditingController();
  TextEditingController carSelectController = TextEditingController();
  TextEditingController gasSelectController = TextEditingController();
  TextEditingController checkTypeController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  String? userUid;
  DateTime koreaNow = DateTime.now();
  @override
  void dispose() {
    companyController.dispose();
    carSelectController.dispose();
    gasSelectController.dispose();
    checkTypeController.dispose();
    distanceController.dispose();
    dateController.dispose();
    carNumberController.dispose();
    super.dispose();
  }

  void validateAndSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {

      await supabase.from('CarPeriodicAdd').insert({
        'company': companyController.text.trim() ?? '',
        'car_select': carSelectController.text.trim() ?? '',
        'gas_select': gasSelectController.text.trim() ?? '',
        'check_type': checkTypeController.text.trim() ?? '',
        'car_number': carNumberController.text.trim() ?? '',
        'distance': int.tryParse(distanceController.text.trim()) ?? 0,
      });


    }

  }
  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
      userUid = user?.id;

  }

}