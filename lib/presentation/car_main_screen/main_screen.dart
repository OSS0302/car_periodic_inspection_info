import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MainScreen extends StatefulWidget {
  final String carSelect;
  final String carNumber;

  const MainScreen({
    Key? key,
    required this.carSelect,
    required this.carNumber,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription? _streamSubscription;

  List<Map<String, dynamic>> _data = [];
  String? userUid;
  bool _isLoading = true;
  bool? isChecked = false;

  @override
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
        .order('date', ascending: false)
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
        title: Text(
          '${widget.carSelect} ${widget.carNumber}님 환영합니다.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await supabase.auth.signOut();
                context.go('/');
              },
              child: Text('로그아웃')),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            carInspectionInfo(context),
            const SizedBox(height: 5),
            carInfo(),
            const SizedBox(height: 5),
            _buildTop(),
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
        height: MediaQuery.of(context).size.height * 0.3,
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
                        '점검',
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
      stream: supabase
          .from('CarPeriodicAdd')
          .stream(primaryKey: ['id']).eq('uid', userUid!),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '점검 내용 ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView(
                    children: data.map((item) {
                      DateTime inspectionDate = DateTime.parse(item['date']);
                      DateTime nextInspectionDate;
                      int additionalDistance = 0;
                      // 날짜 인 경우
                      if (item['check_type'] == '엔진오일' ||
                          item['check_type'] == '에어컨에바' ||
                          item['check_type'] == '히터필터' ||
                          item['check_type'] == '에어컨필터' ||
                          item['check_type'] == '히터클리닝') {
                        nextInspectionDate =
                            inspectionDate.add(Duration(days: 180));

                      } else if (item['check_type'] == '엔진플러싱' ||
                          item['check_type'] == '흡기라인 플러싱' ||
                          item['check_type'] == '휠얼라이먼트' ||
                          item['check_type'] == '브레이크패드' ||
                          item['check_type'] == '파워스티어링오일' ||
                          item['check_type'] == '에어컨냉매점검' ||
                          item['check_type'] == '냉각라인플러싱') {
                        nextInspectionDate =
                            inspectionDate.add(Duration(days: 365));

                      }else if (item['check_type'] == '디퍼런션오일' ||
                          item['check_type'] == '가열플러그' ||
                          item['check_type'] == '가열플러그(예열)' ||
                          item['check_type'] == '트랜스퍼오일' ||
                          item['check_type'] == '파워스티어링오일' ||
                          item['check_type'] == '브레이크오일' ||
                          item['check_type'] == '부동액' ||
                          item['check_type'] == '브레이크 디스크 연마' ||
                          item['check_type'] == '냉각라인플러싱') {
                        nextInspectionDate =
                            inspectionDate.add(Duration(days: 730));

                      } else if (item['check_type'] == '배터리') {
                        nextInspectionDate =
                            inspectionDate.add(Duration(days: 1095));

                      } else if (item['check_type'] == '워터펌프베어링' ||
                          item['check_type'] == '타이밍벨트') {
                        nextInspectionDate =
                            inspectionDate.add(Duration(days: 1460));

                      } else {
                        nextInspectionDate = inspectionDate;
                      }

                      // 연료 유형에 따른 추가 주행거리 계산
                      if (item['gas_select'] == '가솔린' &&
                          item['check_type'] == '엔진오일') {
                        additionalDistance = 7500;

                      } else if (item['gas_select'] == '디젤' &&
                          item['check_type'] == '엔진오일') {
                        additionalDistance = 10000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '히터필터') {
                        additionalDistance = 10000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '디퍼런셜오일' ||
                          item['check_type'] == '휠얼라이먼트' ||
                          item['check_type'] == '에어컨냉매점검') {
                        additionalDistance = 20000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '흡기라인플러싱' ||
                          item['check_type'] == '트랜스퍼오일' ||
                          item['check_type'] == '브레이크패드' ||
                          item['check_type'] == '엔진플러싱') {
                        additionalDistance = 30000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '연소실플러싱' ||
                          item['check_type'] == '가열플러그' ||
                          item['check_type'] == '변속기오일' ||
                          item['check_type'] == '연료휠터' ||
                          item['check_type'] == '브레이크오일' ||
                          item['check_type'] == '부동액' ||
                          item['check_type'] == '냉각라인 플러싱' ||
                          item['check_type'] == '인젝터클리닝' ||
                          item['check_type'] == '일반점화플러그') {
                        additionalDistance = 40000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '배터리') {
                        additionalDistance = 50000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '연소실플러싱' ||
                          item['check_type'] == '파워스티어링 오일' ||
                          item['check_type'] == '외부구동밸트' ||
                          item['check_type'] == '가열플러그' ||
                          item['check_type'] == '일반점화플러그') {
                        additionalDistance = 60000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '타이밍밸트' ||
                          item['check_type'] == '워터펌프베어링' ||
                          item['check_type'] == '백금점화플러그') {
                        additionalDistance = 80000;

                      } else if (item['gas_select'] == '가솔린' &&
                              item['gas_select'] == '디젤' ||
                          item['check_type'] == '밋션 마운팅') {
                        additionalDistance = 100000;
                      }

                      int currentDistance = int.tryParse(item['distance']) ?? 0;
                      int distance =
                          int.parse(item['distance']) + additionalDistance;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(''),
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
                            '점검유형: ${item['check_type']}',
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
                          Text('다음점검 필요: $distance km',
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            '점검일자: ${DateFormat('yyyy년 MM월 dd일 HH시 mm분 ss초').format(DateTime.parse(item['date']).toUtc().add(Duration(hours: 9)))}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            '다음 점검 일자: ${DateFormat('yyyy년 MM월 dd일 ').format(nextInspectionDate.toLocal())}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
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

  Widget _buildTop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                context.push('/hyundaiScreen');
              },
              child: Column(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'http://wiki.hash.kr/images/2/2b/%ED%98%84%EB%8C%80%EC%9E%90%EB%8F%99%EC%B0%A8%E3%88%9C_%EB%A1%9C%EA%B3%A0.png',
                      )),
                  Text('현대'),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'https://image-cdn.hypb.st/https%3A%2F%2Fkr.hypebeast.com%2Ffiles%2F2021%2F01%2Fkia-motors-new-logo-brand-slogan-officially-revealed-01.jpg?cbr=1&q=90',
                      )),
                  Text('기아'),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        'https://tago.kr/images/sub/TG300-D00-img52.jpg',
                      )),
                  Text('쌍용'),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRp-qoM9XlDnnzhQDBmFlKTfgUNkUaAowC7gYjStMmvzl5rshhjQ8yNzNIVqxDOx78TPX4&usqp=CAU',
                      )),
                  Text('로노삼성'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8sZeE4oI950OH1UqdLQqVxii14Z6r9GFh2A&usqp=CAU',
                      )),
                  Text('Tesla'),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'https://thumbnews.nateimg.co.kr/view610///onimg.nate.com/orgImg/mk/2011/01/24/20110124_1295860013.jpg',
                      )),
                  Text('쉐보레'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 50,
                      height: 36,
                      child: Image.network(
                        'https://mblogthumb-phinf.pstatic.net/20160705_13/myredsuns_1467694860567XutrA_JPEG/2.jpg?type=w800',
                      )),
                  Text('BMW'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      width: 50,
                      height: 36,
                      child: Image.network(
                        'https://mblogthumb-phinf.pstatic.net/20160707_205/ppanppane_1467862738612XSIhH_PNG/%BA%A5%C3%F7%B7%CE%B0%ED_%282%29.png?type=w800',
                      )),
                  Text('Benz'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
