import 'dart:async';

import 'package:animation_list/animation_list.dart';
import 'package:car_periodic_inspection_info/data/repository/mock_List_repository_impl.dart';
import 'package:car_periodic_inspection_info/presentation/tab_screen/hyundai_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription? _streamSubscription;
  List<Map<String, dynamic>> _data = [];
  String? userUid;
  bool _isLoading = true;
  bool? isChecked = false;

  void initState() {
    super.initState();
    initializeUserInfoAndSubscribeToChanges();
  }

  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      setState(() {
        userUid = user.id;
      });
      subscribeToUserChanges(user.id);
    }
  }

  void subscribeToUserChanges(String userId) {
    _streamSubscription = supabase
        .from('car_periodic_add')
        .stream(primaryKey: ['id'])
        .eq('uid', userId)
        .order('date')
        .listen((data) {
      setState(() {
        _data = data;
        _isLoading = false;
      });
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
    });
  }


  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아반떼 000님 환영합니다.'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            carInspectionInfo(context),
            const SizedBox(height: 5),
            carInfo(),
            const SizedBox(height: 5),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.95,
                child: InkWell(
                  onTap: () {
                    // 시간이 허락한다면 고라우터로 리팩토링하기
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabPage(),
                      ),
                    );
                  },
                  child: AnimationList(
                    duration: 1500,
                    reBounceDepth: 30,
                    children: listData
                        .map((item) => carInspectionListInfo(
                              item['title'],
                              item['backgroundColor'],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carInspectionInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 0.21,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: const BoxDecoration(),
                      child: const Text(
                        '공지사항',
                        style: TextStyle(fontSize: 30),
                      )),
                ),
                mainBoard('미션오일'),
                mainBoard('엔진오일'),
                mainBoard('브레이크 오일'),
                mainBoard('엔진오일'),
                mainBoard('엔진오일'),
                mainBoard('엔진오일'),
                mainBoard('엔진오일'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget carInfo() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase.from('car_periodic_add').stream(primaryKey: ['id']).eq('uid', userUid!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('에러: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('데이터가 없습니다.'));
        } else {
          List<Map<String, dynamic>> data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView(
                children: data.map((item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '제조회사: ${item['company']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '차량선택: ${item['car_select']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '연료유형: ${item['gas_select']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '차량번호: ${item['car_number']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '주행거리: ${item['distance']} km',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '점검 일자: ${item['date']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget mainBoard(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          checkColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              context.push('/addInfoScreen');
              setState(() {});
            },
            child: const Text('완료'),

          ),
        ),
      ],
    );
  }

  Widget carInspectionListInfo(String title, Color backgroundColor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
