
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../sign_up/sign_up_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  const Text('로그아웃'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () async{
              await supabase.auth.signOut();
              context.go('/');
              }, child: const Text('로그아웃')),
          ),
          ElevatedButton(onPressed: () async{
            await supabase.auth.admin
                .deleteUser('ff735093-e912-45dc-ae70-d1063089b5f9');
          }
              , child: const Text('회원탈퇴')) ,

        ],
      ),
    );
  }
}
