import 'dart:developer';

import 'package:car_periodic_inspection_info/domain/model/car/car_medel.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../car_main_screen/main_screen.dart';

class SignInUpwModel extends ChangeNotifier {
  String getId = '';
  String getPass = '';
  String getNamePass = '';
  String getPhonePass = '';

  void setValue({
    String? idString,
    String? passwordString,
    String? namePass,
    String? phonePass,
  }) {
    getId = idString ?? getId;
    getPass = passwordString ?? getPass;
    getNamePass = namePass ?? getNamePass;
    getPhonePass = phonePass ?? getPhonePass;

    log('getId: $getId, getPass: $getPass, getNamePass: $getNamePass, getPhonePass: $getPhonePass');
  }

  Future<bool> signupSupabase() async {
    final AuthResponse res = await supabase.auth.signUp(
      email: getId,
      password: getPass,
      data: {
        'username': getNamePass,
        'phone': getPhonePass,
      },
    );
    if (res.user != null) {
      await supabase.from('user_info').insert({
        'id': res.user!.id,
        'name': getNamePass,
        'phone': getPhonePass,
      });
      return true;
    } else {
      return false;
    }
  }
}
