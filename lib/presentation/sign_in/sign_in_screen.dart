import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_screen.dart';
import 'package:car_periodic_inspection_info/presentation/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

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
              Text('로그인',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              input('이메일'),
              SizedBox(height: 10,),
              input('패스워드'),
              buttomWidget(context)

            ],
          ),
        ),
      ),
    );
  }
}

Widget input(String text) {
  final _formKey = GlobalKey<FormState>();
  return Form(
    key: _formKey,
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return '이메일 을입력해주세요';
        }
      },
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        hintText: '이메일을 입력하세요',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
Widget buttomWidget (BuildContext context) {
  return Column(
    children: [
      Container(
        width: 300,
        height: 30,
          child: ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen()),
            );
          }, child: Text('로그인'))),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 200,
          height: 30,
            child: ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen()),
              );
            }, child: Text('회원가입'))),
      ),
    ],
  );
}