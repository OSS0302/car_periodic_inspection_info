import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            signUpInfo('아이디'),
            SizedBox(height: 20,),
            signUpInfo('패스워드'),
            SizedBox(height: 20,),
            signUpInfo('패스워드 확인 '),
            SizedBox(height: 20,),
            signUpInfo('이름'),
            SizedBox(height: 20,),
            signUpInfo('전화번호'),
            SizedBox(height: 20,),
            SizedBox(
              width: 200,
              height: 60,
                child: FloatingActionButton(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen()),
                  );
                } ,child: Text('가입 완료',style: TextStyle(fontSize: 30),),))
          ],
        ),
      ),
      
    );
  }
}

Widget signUpInfo(String text) {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return '이메일 을입력해주세요';
      }
    },
    obscureText: false,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      labelText: text,
      hintText: text,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}