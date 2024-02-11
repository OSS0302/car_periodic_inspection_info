import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../sign_up/sign_up_screen.dart';

class SignInViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String getId = '';
  String getPass = '';

  void setValue({bool isPassword = false, String? idString, String? passwordString}) {
    if(isPassword){
      log('pass');
      getPass = passwordString!;
    } else {
      log('id id');
      getId = idString!;
    }
  }

  Future<(String carSelected, String carNumber)?> loginSupabase() async {
    final res = await supabase.auth.signInWithPassword(
      email: getId,
      password: getPass,
    );

    if (res.user != null) {
      final data = await supabase
          .from('CarPeriodicAdd').select('car_select, car_number').eq('uid', res.user!.id);
      String carSelect = '0000';
      String carNumber = '0000000';
      if(data.isNotEmpty){
        carSelect = data[0]['car_select'] ?? '0000';
        carNumber = data[0]['car_number'] ?? '0000000';
      }

      log('carSelect $carSelect, carNumber: $carNumber');

      return (carSelect, carNumber);
    } else {
      return null;
    }
  }
}







