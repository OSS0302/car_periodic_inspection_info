import 'package:car_periodic_inspection_info/presentation/tab_screen/tab_info.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 5,
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
                tabInfo(context, '엔진오일'),
                tabInfo(context, '핸들오일'),
                tabInfo(context, '브레이크오일'),
                tabInfo(context, '와이퍼'),
                tabInfo(context, '냉각수'),
              ],
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                gradient: LinearGradient(
                  //배경 그라데이션 적용
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.black,
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
                tabViewInfo(engineOil),
                tabViewInfo(''),
                tabViewInfo(''),
                tabViewInfo(''),
                tabViewInfo(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget tabInfo(BuildContext context, String title) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.06,
    alignment: Alignment.center,
    child: Text(
      title,
    ),
  );
}

Widget tabViewInfo(String content) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      content,
      style: TextStyle(
        fontSize: 20,
      ),
    ),
  );
}