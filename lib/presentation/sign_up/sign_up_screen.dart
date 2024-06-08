import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModelNotifire = context.read<SignInUpwModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력하세요';
                      }
                      return null;
                    },
                    onChanged: (String value){
                      viewModelNotifire.setValue(idString: value);
                    },
                    // controller: idController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelText: '이메일',
                      hintText: '이메일',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      } else if (value.length < 8) {
                        return '비밀번호는 최소 8자 이상이어야 합니다.';
                      } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                        return '비밀번호에는 최소 한 개의 대문자가 포함되어야 합니다.';
                      } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                        return '비밀번호에는 최소 한 개의 소문자가 포함되어야 합니다.';
                      } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                        return '비밀번호에는 최소 한 개의 숫자가 포함되어야 합니다.';
                      } else if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
                        return '비밀번호에는 최소 한 개의 특수 문자가 포함되어야 합니다.';
                      }
                      return null; // 모든 검증을 통과했다면 null을 반환
                    },
                    onChanged: (String value) {
                      viewModelNotifire.setValue(passwordString:value);
                    },
                    // controller: pwController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelText: '비밀번호',
                      hintText: '비밀번호',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이름을 입력하세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      viewModelNotifire.setValue(namePass: value);
                    },
                    // controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelText: '이름',
                      hintText: '이름',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '전화번호를 입력하세요';
                      }
            
                      return null;
                    },
                      onChanged: (String value) {
                        viewModelNotifire.setValue(phonePass: value);
                      },
                    // controller: phoneController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelText: '전화번호',
                      hintText: '전화번호',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0.h),
                  child: SizedBox(
                    width: 200.w,
                    height: 60.h,
                    child: FloatingActionButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await viewModelNotifire.signupSupabase().then((value) {
                            if(value) {
                              context.go('/');
                            }
                          });
                        }
                      },
                      child: Text(
                        '회원 가입',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}