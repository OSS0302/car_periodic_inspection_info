import 'package:car_periodic_inspection_info/domain/model/car_periodic.dart';

abstract interface class CarPeriodicRepository  {
   Future<CarPeriodic> getCarInfo();
}