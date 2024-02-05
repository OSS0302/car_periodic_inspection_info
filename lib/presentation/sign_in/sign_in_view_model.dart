import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../sign_up/sign_up_screen.dart';

class SignInViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

}

