import 'package:car_periodic_inspection_info/presentation/tab_screen/tab_info.dart';
import 'package:flutter/material.dart';

class HyundaiScreen extends StatefulWidget {
  const HyundaiScreen({Key? key}) : super(key: key);

  @override
  _HyundaiScreenState createState() => _HyundaiScreenState();
}

class _HyundaiScreenState extends State<HyundaiScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 16,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
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
                tabViewInfo(''),
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

class CarPeriodicListScreen extends StatefulWidget {
  const CarPeriodicListScreen({super.key});

  @override
  State<CarPeriodicListScreen> createState() => _CarPeriodicListScreenState();
}

class _CarPeriodicListScreenState extends State<CarPeriodicListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
