import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class CarInfoAddScreen extends StatefulWidget {
  const CarInfoAddScreen({super.key});

  @override
  State<CarInfoAddScreen> createState() => _CarInfoAddScreenState();
}

class _CarInfoAddScreenState extends State<CarInfoAddScreen> {
  final stream = supabase.from('user_info').stream(primaryKey: ['id']);

  TextEditingController companyController = TextEditingController();
  TextEditingController carSelectController = TextEditingController();
  TextEditingController gasSelectController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    companyController.dispose();
    carSelectController.dispose();
    gasSelectController.dispose();
    distanceController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('차량 입력 정보 '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        child: dropDownMenu()),
                  ],
                ),
                TextField(
                  controller: companyController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '제조회사',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: carSelectController,
                  decoration: InputDecoration(
                    hintText: '차량선택',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: gasSelectController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '연료유형',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                    hintText: '주행한 키로수',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async{
                          context.go('/mainScreen');
                          await supabase.from('car_periodic_add').insert({
                            'company': companyController.text ?? '',
                            'car_select':carSelectController.text ?? '',
                            'gas_select': gasSelectController.text?? '',
                            'distance':distanceController.text?? '',
                            'date':  DateFormat("yyyy-MM-dd ").format(DateTime.now()),
                          });

                        },
                        child: Text('작성 완료'))),
              ],
            ),
          ],
        ),
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
        width: 200,
        label: Text(' 차 선택 '),
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
