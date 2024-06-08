
import 'package:car_periodic_inspection_info/presentation/sign_in/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

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
    final viewNotifier = context.read<SignInViewModel>();
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          isLoading = true;
        });

        await viewNotifier.loginSupabase().then((value) {
          if (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('로그인완료'),
              ),
            );
            context.goNamed('/mainScreen');
          } else {
            print('로그인 중 오류 발생');
          }
        });

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('로그인 중 오류 발생');
        setState(() {
          isLoading = false;
        });
      }

      // final res = await supabase.auth.signInWithPassword(
      //   email: idController.text,
      //   password: pwController.text,
      // );

      //   if (res.user != null) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //           behavior: SnackBarBehavior.floating,
      //         content: Text('로그인완료'),
      //       ),
      //     );
      //     context.goNamed('/mainScreen', queryParameters: {'car_select': "000", 'car_number': '00000000'});
      //   }
      // } catch (error) {
      //   print('로그인 중 오류 발생: $error');
      // } finally {
      //   setState(() {
      //     isLoading = false;
      //   });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<SignInViewModel>();
    final viewNotifier = context.read<SignInViewModel>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150.h,
                  child: Center(
                    child: Text(
                      '로그인',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.sp),
                    ),
                  ),
                ),
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjIfxtJWjgQh0Q_MNtzM9PnnKK6_Otv1X71g&usqp=CAU',
                  fit: BoxFit.cover,
                  height: 250.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        viewNotifier.setValue(idString: value);
                      });
                    },
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
                          borderRadius: BorderRadius.circular(16.r)),
                      labelText: '이메일',
                      hintText: '이메일 입력해주세요',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      viewNotifier.setValue(
                          isPassword: true, passwordString: value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력하세요';
                    } else if (value.length < 6) {
                      return '비밀번호는 최소 8자 이상이어야 합니다.';
                    }
                    return null; // 모든 검증을 통과했다면 null을 반환
                  },
                  controller: pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    labelText: 'pw',
                    hintText: '비밀번호를 입력해주세요',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                  child: Container(
                    width: 300.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _signIn,
                      // style: ButtonStyle(
                      //   backgroundColor: context.
                      // ),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      context.push('/SignUpScreen');
                    },
                    child: Text('회원가입')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
