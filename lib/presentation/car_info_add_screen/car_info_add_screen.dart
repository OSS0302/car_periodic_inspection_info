import 'package:flutter/material.dart';

class CarInfoAddScreen extends StatelessWidget {
  const CarInfoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('차량 입력 정보 '),
      ),
      body: Column(
        children: [
          dropDownMenu(),
          textInput(),
        ],
      ),
    );
  }
}

Widget dropDownMenu() {
  return const DropdownMenu(
    label: Text('차량 선택 하기 '),
    dropdownMenuEntries: [
      DropdownMenuEntry(value: Colors.orange, label: '1대'),
      DropdownMenuEntry(value: Colors.green, label: '2대'),
      DropdownMenuEntry(value: Colors.deepPurple, label: '3대'),
      DropdownMenuEntry(value: Colors.yellow, label: '4대'),
      DropdownMenuEntry(value: Colors.lime, label: '5대'),
    ],
  );
}

Widget textInput() {
  return Column(
    children: [
      Expanded(
        child: Row(
          children: [
          TextField(),
          TextField(),
          ],
        ),
      )
    ],
  );
}
