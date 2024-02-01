import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          isLoading = true;
        });

        final res = await supabase.auth.signInWithPassword(
          email: idController.text,
          password: pwController.text,
        );

        if (res.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                behavior: SnackBarBehavior.floating,
              content: Text('로그인완료'),
            ),
          );
          context.go('/mainScreen');
        }
      } catch (error) {
        print('로그인 중 오류 발생: $error');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjIfxtJWjgQh0Q_MNtzM9PnnKK6_Otv1X71g&usqp=CAU',
                      fit: BoxFit.cover),
                  const Text(
                    '로그인',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력하세요';
                        }
                        return null;
                      },
                      autofocus: true,
                      controller: idController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        labelText: '이메일',
                        hintText: '이메일 입력해주세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
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
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return '비밀번호를 입력하세요';
                        }
                        return null;
                      },
                      controller: pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        labelText: 'pw',
                        hintText: '비밀번호를 입력해주세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 300,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: isLoading ? null : _signIn,
                          child: Text('로그인'))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        width: 200,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              context.go('/SignUpScreen');
                            },
                            child: Text('회원가입'))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
