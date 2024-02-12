import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../sign_up/sign_up_screen.dart';

class SignInViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String getId = '';
  String getPass = '';

  void setValue(
      {bool isPassword = false, String? idString, String? passwordString}) {
    if (isPassword) {
      log('pass');
      getPass = passwordString!;
    } else {
      log('id id');
      getId = idString!;
    }
  }

  Future<bool> loginSupabase() async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: getId,
        password: getPass,
      );
      if (res.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
    // final res = await supabase.auth.signInWithPassword(
    //   email: getId,
    //   password: getPass,
    // );
    //
    // if (res.user != null) {
    //   final data = await supabase
    //       .from('user_info')
    //       .select('name, phone')
    //       .eq('id', supabase.auth.currentUser!.id);
    //
    //   String name = '';
    //   String phone = '';
    //   log('message ???? ${data}');
    //   if (data.isNotEmpty) {
    //     name = '${data[0]['name']}(${data[0]['phone']})';
    //     log('message?? ${data[0]['name']}');
    //   }
    //
    //   log('name $name, carNumber: $phone');
    //
    //   return name;
    // } else {
    //   return null;
    // }
  }
}
