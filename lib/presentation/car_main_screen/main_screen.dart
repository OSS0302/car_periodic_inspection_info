import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> data = [
    {
      'title': '1111',
      'backgroundColor': Colors.grey,
    },
    {
      'title': '2222',
      'backgroundColor': Colors.red,
    },
    {
      'title': '3333',
      'backgroundColor': Colors.yellow,
    },
    {
      'title': '4444',
      'backgroundColor': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아반떼 000님 환영 합니다. '),
      ),
      body: Expanded(
        child: Column(
          children: [
            carInspectionInfo(context),
            infoTable(),

          ],
        ),
      ),
    );
  }
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
      height: MediaQuery.of(context).size.height * 0.25,
    ),
  );
}

Widget infoTable() {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: DataTable(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      border: TableBorder.all(),
      columns: const [
        DataColumn(label: Text('정기점검')),
        DataColumn(label: Text('주행거리')),
        DataColumn(label: Text('교체주기')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('미션오일')),
          DataCell(Text('100,000km')),
          DataCell(Text('2024-10-19')),
        ]),
        DataRow(cells: [
          DataCell(Text('엔진오일')),
          DataCell(Text(
            '광유:7,000~10,000km 합성유: 10,000~15,000km',
            style: TextStyle(fontSize: 7),
          )),
          DataCell(Text('2024-10-19')),
        ]),
        DataRow(cells: [
          DataCell(Text('브레이크 오일')),
          DataCell(Text('50,000km')),
          DataCell(Text('2024-10-19')),
        ]),
      ],
    ),
  );
}


