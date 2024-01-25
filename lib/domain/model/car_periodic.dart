import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'car_periodic.freezed.dart';

part 'car_periodic.g.dart';

@freezed
class CarPeriodic with _$CarPeriodic {
  const factory CarPeriodic({
    //1. 엔진오일
    @Default("")  String engineOil,
    //2. 엔진플러싱(세정)
    @Default("")  String cleaningEngineFlushing,
    //3-1. 코일 점화 플러그
    @Default("")  String coilSparkPlug,
    // 3-2 베이블 점화 플러그
    @Default("")  String beBelSparkPlug,
    // 4. 연소실 플러싱(세정)
    @Default("")  String cleaningCombustionChamberFlushing,
    // 5. 가열 플러그(예열)
    @Default("") String preheatingHeatingPlug,
    // 6. 흡기라인 플러싱(세정)
    @Default("")  String cleaingIntakeLineFlushing,
    // 7. 타이밍벨트
    @Default("")  String timingBelt,
    // 8. 체인 방식 워터펌프 베어링 set
    @Default("")  String waterPumpBearingSet,
    // 9. 외부구동 밸트(휀)
    @Default("")  String externalDriveBelt,
    // 10. 미션마운팅
    @Default("")  String engineTransmissionMounting,
    // 11. 변속기 오일
    @Default("") String transmissionOil ,
    // 12. 디퍼련셜 오일
    @Default("") String differentialOil ,
    // 13. 트랜스퍼 오일
    @Default("") String transferOil ,
    // 14.연료 휠터
    @Default("") String fuelFilter ,
    //15. 인젝터클리닝(연료라인)
    @Default("") String fuelInjectorCleaning,
    // 16. 브레이크 패드
    @Default("") String brakePad,
    // 17. 브레이크 오일
    @Default("") String brakeOil,
    // 18. 브레이크 디스크 연마
    @Default("") String  brakeDiscPolishing,
    // 19. 부동액
    @Default("")  String antifreeze,
    // 20. 냉각라인 플러싱(세정)
    @Default("") String cleaingCoolingLineFlushing,
    //21. 히터 앤 에어컨 필터
    @Default("") String Filter,
    // 22.에어컨에바 / 히터클리닝(세정)
    @Default("") String cleaningAirConditionerHeater,
    // 23.  에어컨 냉매점검
    @Default("") String airConditionerRefrigerantInspection,
    // 24. 파워 스티어링
    @Default("") String PowerSteeringOil,
    // 25. 바퀴 정렬
    @Default("") String wheelAlignment,
    // 26 밧데리
    @Default("") String battery,
    // 27. 하체 언더 코딩
    @Default("") String lowerBodyUndercoating,


  }) = _CarPeriodic;

  factory CarPeriodic.fromJson(Map<String, Object?> json) => _$CarPeriodicFromJson(json);
}