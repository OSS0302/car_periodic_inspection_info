import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../car_main_screen/main_screen.dart';
import 'hyundai_tab_info.dart';

class HyundaiScreen extends StatefulWidget {
  const HyundaiScreen({Key? key}) : super(key: key);

  @override
  _HyundaiScreenState createState() => _HyundaiScreenState();
}

class _HyundaiScreenState extends State<HyundaiScreen> with TickerProviderStateMixin {
  late final Stream<List<Map<String, dynamic>>> carDataStream;
  late TabController _tabController;
  String? userUid;

  @override
  void initState() {
    super.initState();
    initializeUserInfoAndSubscribeToChanges();
    _tabController = TabController(length: 16, vsync: this);
    carDataStream = supabase
        .from('CarPeriodicAdd')
        .stream(primaryKey: ['id'])
        .eq('uid', userUid!)
        .order('date', ascending: false)
        .map((list) => list.map((map) => map as Map<String, dynamic>).toList());
  }
  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      setState(() {
        userUid = user.id;
      });

    }
  }

  Widget carPeriodicInfo() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: carDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("데이터가 없습니다."));
        }
        var data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            DateTime inspectionDate = DateTime.parse(item['date']);
            DateTime nextInspectionDate;
            int additionalDistance = 0;
            // 날짜 인 경우
            if (item['check_type'] == '엔진오일' ||
                item['check_type'] == '에어컨에바' ||
                item['check_type'] == '히터필터' ||
                item['check_type'] == '에어컨필터' ||
                item['check_type'] == '히터클리닝') {
              nextInspectionDate = inspectionDate.add(Duration(days: 180));

            } else if (item['check_type'] == '엔진플러싱' ||
                item['check_type'] == '흡기라인플러싱' ||
                item['check_type'] == '휠얼라이먼트' ||
                item['check_type'] == '브레이크패드' ||
                item['check_type'] == '에어컨냉매점검' ||
                item['check_type'] == '냉각라인플러싱') {
              nextInspectionDate = inspectionDate.add(Duration(days: 365));

            }else if (item['check_type'] == '디퍼런셜오일' ||
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
              nextInspectionDate = inspectionDate.add(Duration(days: 730));

            } else if (item['check_type'] == '배터리'||
                item['check_type'] == '외부구동밸트' ) {
              nextInspectionDate = inspectionDate.add(Duration(days: 1095));

            } else if (item['check_type'] == '워터펌프베어링' ||
                item['check_type'] == '백금플러그'||
                item['check_type'] == '타이밍밸트') {
              nextInspectionDate = inspectionDate.add(Duration(days: 1460));

            } else if (item['check_type'] == '미션마운팅') {
              nextInspectionDate = inspectionDate.add(Duration(days: 1825));

            } else {
              nextInspectionDate = inspectionDate;
            }

            // 연료 유형에 따른 추가 주행거리 계산
            if (item['gas_select'] == '가솔린' &&
                item['check_type'] == '엔진오일') {
              additionalDistance = 7500;

            } else if (item['gas_select'] == '디젤' &&
                item['check_type'] == '엔진오일'||
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

            int currentDistance = int.tryParse(item['distance']) ?? 0;
            int distance =
                int.parse(item['distance']) + additionalDistance;
            return Column(
              children: [
                ListTile(
                  title: Text('${item['car_select']}: ${item['car_number']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    subtitle: Text('주행거리: ${item['distance']} km,\n다음점검 필요: $distance km \n점검유형: ${item['check_type']}\n''점검일자: ${DateFormat('yyyy년 MM월 dd일 ').format(DateTime.parse(item['date']).toUtc().add(Duration(hours: 9)))}'
                      ,style:TextStyle(fontSize: 15) ,),
                ),
                Divider(thickness: 1,color: Colors.black,),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '정기정보앱',
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: TabBar(
              indicatorColor: Colors.blue,
              indicatorWeight: 2,
              isScrollable: true,
              tabs: [
                tabInfo( '내차량 최근  보기'),
                tabInfo('오일'),
                tabInfo( '플러싱(세정)'),
                tabInfo( '플러그'),
                tabInfo( '벨트'),
                tabInfo( '체인 방식 워터펌프 베어링 set'),
                tabInfo( '변속기 오일 '),
                tabInfo( '연료휠터'),
                tabInfo( '인젝터클리닝'),
                tabInfo( '브레이크'),
                tabInfo( '부동액'),
                tabInfo( '에어컨 과 필터'),
                tabInfo('파워스티터어링 오일'),
                tabInfo('밧데리'),
                tabInfo('하체 언더코팅 '),
                tabInfo( '와이퍼'),

              ],
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  //배경 그라데이션 적용
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Colors.indigo,
                  ],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                carPeriodicInfo(),
                tabViewInfo(engineOil),
                tabViewInfo(cleaningFlushing),
                tabViewInfo(sparkPlug),
                tabViewInfo(timingBelt),
                tabViewInfo(waterPumpBearingSet),
                tabViewInfo(engineTransmissionMounting),
                tabViewInfo(fuelFilter),
                tabViewInfo(fuelInjectorCleaning),
                tabViewInfo(brake),
                tabViewInfo(antifreeze),
                tabViewInfo(airCondition),
                tabViewInfo(wheelAlignment),
                tabViewInfo(battery),
                tabViewInfo(lowerBodyUndercoating),
                tabViewInfo(wiper),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget tabInfo( String title) {
  return Container(
    height: 60,
    alignment: Alignment.center,
    child: Text(
      title,
    ),
  );
}

Widget tabViewInfo(String content) {
  return ListView(
    children: [
      Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ],
  );
}


