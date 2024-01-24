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
              indicatorWeight: 1,
              isScrollable: true,
              tabs: [
                tabInfo(context,'핸들오일'),
                tabInfo(context,'엔진오일'),
                tabInfo(context,'브레이크오일'),
                tabInfo(context,'와이퍼'),
                tabInfo(context,''),
              ],
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                gradient: LinearGradient(
                  //배경 그라데이션 적용
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.purpleAccent,
                    Colors.greenAccent,
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
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '핸들오일',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '미션오일',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '엔진오일',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '브레이크 오일',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '브레이크 오일',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 Widget tabInfo(BuildContext context ,String title) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.06,
    alignment: Alignment.center,
    child: Text(
      title,
    ),
  );
 }