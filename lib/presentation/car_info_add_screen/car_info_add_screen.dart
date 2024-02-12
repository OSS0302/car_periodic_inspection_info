import 'package:car_periodic_inspection_info/presentation/car_info_add_screen/car_info_add_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/model/car/car_medel.dart';

final supabase = Supabase.instance.client;

class CarInfoAddScreen extends StatefulWidget {
  final CarModel? selectedCar;
  const CarInfoAddScreen({Key? key, this.selectedCar}) : super(key: key);

  @override
  State<CarInfoAddScreen> createState() => _CarInfoAddScreenState();
}

class _CarInfoAddScreenState extends State<CarInfoAddScreen> {
  final stream = supabase.from('CarPeriodicAdd').stream(primaryKey: ['id']);
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      final viewModelNoti = context.read<CarInfoAddViewModel>();
      viewModelNoti.initializeUserInfoAndSubscribeToChanges(
          selectedCar: widget.selectedCar);
      if (widget.selectedCar != null) {
        setState(() {
          companyController.text = widget.selectedCar?.company ?? '';
          carSelectController.text = widget.selectedCar?.carName ?? '';
          gasSelectController.text = widget.selectedCar?.gasType ?? '';
          distanceController.text =
              widget.selectedCar?.distance.toString() ?? '';
          // dateController.text = widget.selectedCar?.company ?? '';
          carNumberController.text = widget.selectedCar?.carNumber ?? '';
        });
      }
    });
  }

  TextEditingController companyController = TextEditingController();
  TextEditingController carSelectController = TextEditingController();
  TextEditingController gasSelectController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  String? userUid;

  @override
  void dispose() {
    companyController.dispose();
    carSelectController.dispose();
    gasSelectController.dispose();
    distanceController.dispose();
    dateController.dispose();
    carNumberController.dispose();
    super.dispose();
  }

  Future<void> initializeUserInfoAndSubscribeToChanges() async {
    final user = supabase.auth.currentUser;
    setState(() {
      userUid = user?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CarInfoAddViewModel>();
    final noti = context.read<CarInfoAddViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('차량 입력 정보 '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '제조 회사를 입력 해 주세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      viewModel.setValue(companyString: value);
                    },
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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '차량 선택하세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      viewModel.setValue(carSelectString: value);
                    },
                    controller: carSelectController,
                    decoration: InputDecoration(
                      hintText: '차량선택',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '차량 선택하세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      viewModel.setValue(gasSelectString: value);
                    },
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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '차량 선택하세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      int changInt = int.tryParse(value) ?? 0;
                      viewModel.setValue(dinstanceInt: changInt);
                    },
                    controller: distanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '주행한 키로수',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '차량 번호 입력해주세요';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      viewModel.setValue(carNumberString: value);
                    },
                    controller: carNumberController,
                    decoration: InputDecoration(
                      hintText: '차량 번호 입력',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<String>(
                    value: viewModel.selectedSettingType,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        noti.changeSelectedSettingType(value!);
                      });
                    },
                    items: viewModel.settingType.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await viewModel.validateAndSubmit().then((value) {
                                if (value) {
                                  context.pop();
                                }
                              });
                            }
                          },
                          child: Text('작성 완료'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
