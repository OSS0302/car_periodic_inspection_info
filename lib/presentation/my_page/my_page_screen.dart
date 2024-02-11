import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final supbaseAdmin = supabase.auth.admin;

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String? userUid;


  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      setState(() {
        userUid = user.id;
      });
    }
  }

  @override
  void initState() {
    initializeUserInfoAndSubscribeToChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그아웃'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                  context.go('/');
                },
                child: Text('로그아웃')),
          ),
          ElevatedButton(
            onPressed: userUid != null
                ? () async {
                    try {
                      await supabase.auth.admin.deleteUser(userUid!);
                      await supabase.auth.signOut();
                      context.go('/');
                    } catch (e) {
                      print('회원 탈퇴 중 오류 발생: $e');
                    }
                  }
                : null,
            child: const Text('회원탈퇴'),
          )
        ],
      ),
    );
  }
}
