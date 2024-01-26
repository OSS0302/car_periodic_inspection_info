import 'package:animation_list/animation_list.dart';
import 'package:car_periodic_inspection_info/data/repository/mock_List_repository_impl.dart';
import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_screen.dart';
import 'package:car_periodic_inspection_info/presentation/tab_screen/hyundai_tab_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아반떼 000님 환영 합니다. '),
      ),
      body: Column(
        children: [
          carInspectionInfo(context),
          SizedBox(
            height: 5,
          ),
          CarInfoTable(),
          SizedBox(height: 5,),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.95,
              child: InkWell(
                onTap: () {
                  // 시간될떄 고라우터 로 리펙토링 하기
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TabPage()),
                  );
                },
                child: AnimationList(
                    duration: 1500,
                    reBounceDepth: 30,
                    children: data.map((item) {
                      return carInspectionListInfo(
                          item['title'], item['backgroundColor']);
                    }).toList()),
              ),
            ),
          ),

        ],
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
                      child: Text(
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
            )
          ],
        ),
      ),
    );
  }

  Widget mainBoard(String title) {
    bool? _isChecked = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          checkColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value;
            });
          },
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CarInfoAddScreen()),
              );
            },
            child: Text('완료')),
      ],
    );
  }

  Widget CarInfoTable() {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: const BoxDecoration(),
                      child: Text(
                        '메인 보드 ',
                        style: TextStyle(fontSize: 30),
                      )),
                  ),
                mainCarInfo('엔진오일', '10000km', '점검완료'),
                mainCarInfo('브레이크오일', '20000km', '점검완료'),
                mainCarInfo('브레이크패드', '30000km', '점검완료'),
                mainCarInfo('미션오일', '40000km', '점검완료'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget mainCarInfo(String title, String content, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text (title),
        Text (content),
        Text (text),
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
