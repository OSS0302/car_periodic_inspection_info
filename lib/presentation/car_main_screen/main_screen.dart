import 'dart:async';
import 'dart:convert';
import 'package:car_periodic_inspection_info/presentation/car_main_screen/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/model/car/car_model.dart';

final supabase = Supabase.instance.client;

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _carInspectionScrollController = ScrollController();
  final ScrollController _carInfoScrollController = ScrollController();

  Timer? timer;
  DateTime nowDate = DateTime.now();

  @override
  void initState() {
    Future.microtask(() {
      final notifier = context.read<MainViewModel>();
      notifier.getReady();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${viewmodel.userName}님 환영합니다.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await showDialog(context: context, builder: (BuildContext context) { return AlertDialog( content: const Text('로그아웃 하시겠습니까.'),actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('닫기'),
                  ),
                  TextButton(
                    onPressed: () async{
                      await supabase.auth.signOut();
                      context.pop(true);
                      context.go('/');
                    },
                    child: const Text('확인'),
                  ),
                ],); });

              },
              child: Text('로그아웃')),
        ],
      ),
      body: viewmodel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Column(
                  children: [
                    selectAddCar(),
                    _buildTop(),
                    carInspectionInfo(context),
                    carInfo(),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget selectAddCar() {
    final viewmodel = context.watch<MainViewModel>();
    final noti = context.read<MainViewModel>();
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  context.push('/addScreen').then((value) {
                    final notifier = context.read<MainViewModel>();
                    notifier.getReady();
                  });
                },
                child: Text('차량등록'),
              ),
              viewmodel.userCarList.isNotEmpty
                  ? DropdownButton<String>(
                      value: viewmodel.selectedCar!.carNumber,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          noti.changeSelectCar(value!);
                        });
                      },
                      items: viewmodel.userCarList
                          .map<DropdownMenuItem<String>>((CarModel value) {
                        return DropdownMenuItem<String>(
                          value: value.carNumber,
                          child: Text(value.carNumber),
                        );
                      }).toList(),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget carInspectionInfo(BuildContext context) {
    final viewmodel = context.watch<MainViewModel>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0).r,
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '점검',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewmodel.userCarList.isNotEmpty) {
                      CarModel selected = viewmodel.selectedCar!;
                      context.pushNamed(
                        'addInfoScreen',
                        queryParameters: {
                          'selected_car': json.encode(selected)
                        },
                      ).then((value) {
                        final notifier = context.read<MainViewModel>();
                        notifier.getReady();
                        setState(() {});
                      });
                    } else {
                      context.pushNamed('addInfoScreen').then((value) {
                        final notifier = context.read<MainViewModel>();
                        notifier.getReady();
                        setState(() {});
                      });
                    }
                  },
                  child: const Text('차량 점검'),
                ),
              ],
            ),
          ),
        ),
        Padding(
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
              child: Scrollbar(
                controller: _carInspectionScrollController,
                radius: Radius.circular(16.0.r),
                thickness: 8.w,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _carInspectionScrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainBoard(
                            title: '변속기오일',
                            timeDate:
                                viewmodel.selectedCar?.missionOilLastDate ??
                                    ''),
                        mainBoard(
                            title: '엔진오일',
                            timeDate:
                                viewmodel.selectedCar?.engineOilLastDate ?? ''),
                        mainBoard(
                            title: '브레이크오일',
                            timeDate:
                                viewmodel.selectedCar?.breakOilLastDate ?? ''),
                        mainBoard(
                            title: '브레이크패드',
                            timeDate:
                                viewmodel.selectedCar?.breakPadLastDate ?? ''),
                        mainBoard(
                            title: '파워스테어링오일',
                            timeDate: viewmodel
                                    .selectedCar?.powerSteeringWheelLastDate ??
                                ''),
                        mainBoard(
                            title: '디퍼런셜오일',
                            timeDate: viewmodel.selectedCar?.differentialOilLastDate ?? ''),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget carInfo() {
    final viewModel = context.watch<MainViewModel>();
    return viewModel.selectedCar != null
        ? StreamBuilder<List<Map<String, dynamic>>>(
            stream: supabase
                .from('CarPeriodicAdd')
                .stream(primaryKey: ['id']).eq(
                    'car_number', viewModel.selectedCar!.carNumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('에러: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('데이터가 없습니다.'));
              } else {
                List<Map<String, dynamic>> data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                      child: Text(
                        '점검 내용',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14).r,
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
                      child: Padding(
                        padding: EdgeInsets.all(8.0).r,
                        child: Scrollbar(
                          controller: _carInfoScrollController,
                          radius: Radius.circular(16.0.r),
                          thickness: 8.w,
                          thumbVisibility: true,
                          child: ListView(
                            controller: _carInfoScrollController,
                            children: data.map((item) {
                              DateTime inspectionDate =
                                  DateTime.parse(item['date']);
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
                                  item['check_type'] == '흡기라인플러싱' ||
                                  item['check_type'] == '휠얼라이먼트' ||
                                  item['check_type'] == '브레이크패드' ||
                                  item['check_type'] == '에어컨냉매점검' ||
                                  item['check_type'] == '냉각라인플러싱') {
                                nextInspectionDate =
                                    inspectionDate.add(Duration(days: 365));
                              } else if (item['check_type'] == '디퍼런셜오일' ||
                                  item['check_type'] == '가열플미러그' ||
                                  item['check_type'] == '연료휠터' ||
                                  item['check_type'] == '트랜스퍼오일' ||
                                  item['check_type'] == '파워스티어링오일' ||
                                  item['check_type'] == '브레이크오일' ||
                                  item['check_type'] == '연소실플러싱' ||
                                  item['check_type'] == '부동액' ||
                                  item['check_type'] == '인젝터클리닝' ||
                                  item['check_type'] == '변속기오일' ||
                                  item['check_type'] == '브레이크디스크연마' ||
                                  item['check_type'] == '냉각라인플러싱') {
                                nextInspectionDate =
                                    inspectionDate.add(Duration(days: 730));
                              } else if (item['check_type'] == '배터리' ||
                                  item['check_type'] == '외부구동밸트') {
                                nextInspectionDate =
                                    inspectionDate.add(Duration(days: 1095));
                              } else if (item['check_type'] == '워터펌프베어링' ||
                                  item['check_type'] == '백금플러그' ||
                                  item['check_type'] == '타이밍밸트') {
                                nextInspectionDate =
                                    inspectionDate.add(Duration(days: 1460));
                              } else if (item['check_type'] == '미션마운팅') {
                                nextInspectionDate =
                                    inspectionDate.add(Duration(days: 1825));
                              } else {
                                nextInspectionDate = inspectionDate;
                              }

                              // 연료 유형에 따른 추가 주행거리 계산
                              if (item['gas_select'] == '가솔린' &&
                                  item['check_type'] == '엔진오일') {
                                additionalDistance = 7500;
                              } else if (item['gas_select'] == '디젤' &&
                                      item['check_type'] == '엔진오일' ||
                                  item['check_type'] == '히터클리닝') {
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
                                  item['check_type'] == '브레이크디스크연마' ||
                                  item['check_type'] == '파워스티어링오일' ||
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
                                  item['check_type'] == '미션마운팅') {
                                additionalDistance = 100000;
                              }

                              int currentDistance =
                                  int.tryParse(item['distance']) ?? 0;
                              int distance = int.parse(item['distance']) +
                                  additionalDistance;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(''),
                                  Text(
                                    '제조회사: ${item['company']}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '차량선택: ${item['car_select']}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '연료유형: ${item['gas_select']}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '점검유형: ${item['check_type']}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '차량번호: ${item['car_number']}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '주행거리: ${item['distance']} km',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '다음점검 필요: $distance km',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '점검일자: ${DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(item['date']).toUtc().add(Duration(hours: 9)))}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '다음 점검 일자: ${DateFormat('yyyy년 MM월 dd일 ').format(nextInspectionDate.toLocal())}',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )
        : Container();
  }

  Widget mainBoard({
    required String title,
    String timeDate = '',
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(timeDate),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 12.0.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.push('/hyundaiScreen');
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          width: 40.w,
                          height: 40.h,
                          child: Image.network(
                            'http://wiki.hash.kr/images/2/2b/%ED%98%84%EB%8C%80%EC%9E%90%EB%8F%99%EC%B0%A8%E3%88%9C_%EB%A1%9C%EA%B3%A0.png',
                          )),
                      Text('현대'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push('/kiaScreen');
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          width: 40.w,
                          height: 40.h,
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
                          width: 50.w,
                          height: 50.h,
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
                          width: 40.w,
                          height: 40.h,
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
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                          width: 40.w,
                          height: 40.h,
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
                          width: 40.w,
                          height: 40.h,
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
                          width: 50.w,
                          height: 36.h,
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
                          width: 50.w,
                          height: 36.h,
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
        ),
      ),
    );
  }
}
