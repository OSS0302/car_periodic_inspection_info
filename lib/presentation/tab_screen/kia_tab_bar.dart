import 'package:car_periodic_inspection_info/presentation/tab_screen/hyundai_tab_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../car_main_screen/main_screen.dart';

class KiaScreen extends StatefulWidget {
  const KiaScreen({Key? key}) : super(key: key);

  @override
  _KiaScreenState createState() => _KiaScreenState();
}

class _KiaScreenState extends State<KiaScreen> with TickerProviderStateMixin {
  late final Stream<List<Map<String, dynamic>>> carDataStream;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 16, vsync: this);
    carDataStream = supabase
        .from('CarPeriodicAdd')
        .stream(primaryKey: ['id'])
        .order('date', ascending: false)
        .map((list) => list.map((map) => map as Map<String, dynamic>).toList());
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
            return Column(
              children: [
                ListTile(
                  title: Text('${item['car_select']}: ${item['car_number']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    subtitle: Text('주행거리: ${item['distance']} km, \n점검유형: ${item['check_type']}\n''점검일자: ${DateFormat('yyyy년 MM월 dd일 HH시 mm분 ss초').format(DateTime.parse(item['date']).toUtc().add(Duration(hours: 9)))}'
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
        backgroundColor: Colors.redAccent,
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

              labelColor: Colors.black,
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


