import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인 페이지'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjIfxtJWjgQh0Q_MNtzM9PnnKK6_Otv1X71g&usqp=CAU'),
              const Text('로그인',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              TextFormField(
                controller: idController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
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
              TextFormField(
                controller: pwController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
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
              Container(
                  width: 300,
                  height: 30,
                  child: ElevatedButton(onPressed: ()  async {

                    context.go('/mainScreen');
                    final AuthResponse res = await supabase.auth.signInWithPassword(
                      email: idController.text,
                      password: pwController.text,
                    );
                  },

                      child: Text('로그인'))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: 200,
                    height: 30,
                    child: ElevatedButton(onPressed: () {
                      context.go('/SignUpScreen');


                    }, child: Text('회원가입'))),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


