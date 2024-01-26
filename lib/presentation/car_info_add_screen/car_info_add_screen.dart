import 'package:flutter/material.dart';

class CarInfoAddScreen extends StatefulWidget {

  const CarInfoAddScreen({super.key});

  @override
  State<CarInfoAddScreen> createState() => _CarInfoAddScreenState();
}

class _CarInfoAddScreenState extends State<CarInfoAddScreen> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('차량 입력 정보 '),
      ),
      body: Column(
        children: [
          Row(
            children: [
              dropDownMenu(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          textInput(),
          carInspectionInput(),
          buttom(context),
        ],
      ),

    );
  }
}

Widget dropDownMenu() {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        label: Text('차량 선택 하기 '),
        dropdownMenuEntries: [
          DropdownMenuEntry(value: Colors.orange, label: '1대'),
          DropdownMenuEntry(value: Colors.green, label: '2대'),
          DropdownMenuEntry(value: Colors.deepPurple, label: '3대'),
          DropdownMenuEntry(value: Colors.yellow, label: '4대'),
          DropdownMenuEntry(value: Colors.lime, label: '5대'),
        ],
      ),
    ),
  );
}

Widget textInput() {
  return const Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '제조회사',
                  border: OutlineInputBorder(
                  ),
                ),

              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '차량선택',
                  border: OutlineInputBorder(),
                ),
              ),
            ),Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '연료유형',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget carInspectionInput() {
  return const Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '제조회사',
                  border: OutlineInputBorder(
                  ),
                ),

              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '점검한 km 입력',
                  border: OutlineInputBorder(),
                ),
              ),
            ),Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '점검날짜',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buttom (BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(onPressed: () {
          () =>  Navigator.pop(context);
        } , child: Text('완료')),
      ],
    ),
  );
}