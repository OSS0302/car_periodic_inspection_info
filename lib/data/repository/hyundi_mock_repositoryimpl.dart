import 'package:car_periodic_inspection_info/domain/model/car_periodic.dart';
import 'package:car_periodic_inspection_info/domain/repository/car_periodic_repository.dart';

class CarInfoRepositoryImpl implements CarPeriodicRepository {
  @override
  Future<CarPeriodic> getCarInfo() async {
    await Future.delayed(const Duration(seconds: 1));

  [
      {
        "maintenanceItems": {
          "engineOil": {
            "initial": "최초 5,000km",
            "gasoline": "7,500km",
            "diesel": "10,000km"
          },
          "customerChoice": {
            "harshConditions": "필요시 / 정기 점검",
            "regular": "6개월 / 1년 2회"
          },
          "lowMileageVehicle": {
            "engineFlushing": "매 2 ~ 30,000km",
            "sludgeOccurrence": "엔진 스러지 발생 시 또는 합성 오일 교환 시",
            "sparkPlugsCoils": "매 40,000km (일반)"
          },
          "inspectionAndReplacement": {
            "sparkPlugs": "매 40,000km",
            "platinumPlugs": "매 80,000km",
            "combustionChamberFlushing": "매 40,000km / 2년",
            "ignitionPlugPreheating": "매 40,000km / 2년",
            "intakeLineFlushing": "매 2 ~ 30,000km",
            "timingBelt": "매 60,000km",
            "earlyReplacement": "매 80,000km",
            "chainSystem": "매 80,000km",
            "chainSystemInspection": "100,000km 기준으로 소음 또는 누유 확인",
            "externalDriveBelt": "매 60,000km",
            "engineTransmissionMounting": "매 80,000 ~ 100,000km",
            "transmissionOilManual": "매 40,000km (최초 10,000km 교환)",
            "transmissionOilAuto": "매 40,000km",
            "autoTransmissionOilCheck": "오염 및 오일 레벨에 따라 확인",
            "autoTransmissionNoChange": "6단 이상 오토 (무교환)",
            "earlyChange": "70,000km 또는 가혹한 조건에서 조기 교환",
            "differentialOil": "매 20,000km / 2년",
            "transferOil": "매 30,000km / 2년",
            "fuelFilter": "매 40,000km / 2년",
            "fuelFilterImmediate": "수분이 감지되면 즉시 교체",
            "LPIVehicle": {
              "injectorCleaning": "매 40,000km / 2년",
              "dieselVehicle": "연기 발생, 휘발유 부족, 수분 침입, 동력 부족 시",
              "LPIVehicleImmediate": "LPI (LPG) 차량의 경우 시동 실패 또는 엔진 미스파이어가 발생하면 즉시 시행"
            },
            "brakePads": "매 30,000km",
            "brakePadsInspection": "정기 점검",
            "brakeOil": "매 3 ~ 40,000km / 2년",
            "brakeOilChange": "수분 함유량이 높거나 오염이 있을 경우 205℃ 이하에서 교체",
            "brakeDiskGrinding": "매 40,000km",
            "brakeDiskGrindingCheck": "제동 중 브레이크 페달이 떨리거나 소음이 발생하는 경우 확인",
            "coolant": "2년 & 40,000km",
            "coolantImmediate": "오염이 감지되면 즉시 교체",
            "coolantLineFlushing": "매 40,000km / 2년",
            "coolantLineFlushingImmediate": "냉각수 오염 또는 녹이 발생하면 즉시",
            "heaterAirFilter": "매 12,000km (통상 조건)",
            "heaterAirFilterHarsh": "매 10,000km (가혹한 조건)",
            "airConditionerCleaning": "1 ~ 2년에 1회",
            "airConditionerCleaningImmediate": "에어컨이나 히터에서 냄새가 나는 경우",
            "airConditionerRefrigerantCheck": "매 20,000km",
            "airConditionerRefrigerantCheckYearly": "매 1년에 1회, 보충",
            "airConditionerRefrigerantChange": "매 40,000km, 3년마다 가스 및 냉동유 교체",
            "powerSteeringOil": "매 40,000km / 2년",
            "powerSteeringOilChange": "오염이나 힘의 저항이 증가한 경우 교체",
            "wheelAlignment": "매 20,000km",
            "wheelAlignmentCheck": "타이어 마모 또는 핸들 문제 발생 시 확인",
            "battery": "3년 & 5만 km",
            "batteryChange": "시동 성능이 감소한 경우 확인 및 교체",
            "undercoating": "신차 출고시 권장",
            "undercoatingPurpose": "부식 방지 및 소음 감소를 위한 것"
          }
        }
      }
    ];
    return CarPeriodic();
  }



// 품  목
// 교환 및 세정주기
// 운행조건
// 엔진오일
// 최초 5,000km
//
// 고객 선택 항목
//
// 가솔린 매 7,500km / 디젤 매 10,000km
// 가혹조건 / 수시점검
//
// 6개월 / 년 2회
//
// 운행이 적은 차량
//
// 엔진플러싱(세정)
// 매 2 ~ 30,000km
// 엔진내부 슬러지 발생시 / 합성유 오일로 교환시
// 점화플러그 & 코일, 베이블
// 매 40,000km(일반)
//
// 매 40,000km 점검, 교환
// 매 80,000km(백금)
// 연소실 플러싱(세정)
// 매 40,000kn / 2년
// 플러그 교환시 동시 시행 권장
// 가열플러그(예열)
// 매 40,000km / 2년
// 매 40,000km마다 점검, 교환
// 흡기라인 플러싱(세정)
// 매 2 ~ 30,000km
// 공기 흡입라인 스로틀바디 카본 및 슬러지 제거
// 타이밍밸트	매 60,000km
// 일부차량 조기교환
// 매 80,000km
// 5년이상 경과 차량, 시내주행 및 공회전이 많은 차량
// 체인방식 : 워터펌프 베어링 SET
// 매 80,000km
// 10만km 점검 / 소음, 누유 발생시 즉시 교환
// 외부구동밸트 (휀)
// 매 60,000km
// 수시점검 이상시 교환
// 엔진 / 밋션 마운팅
// 매 8~10만km
// 정차 중 진동시 / 누유 및 크랙 발생시 교환
// 변속기오일(밋션오일)	수동 : 매 40,000km
// 최초 10,000km 교환
// 오토 : 매 40,000km
// 오염도와 오일량에 따라 수시점검 및 교환
// 6속 이상 오토 (무교환)
// 70,000km 주행시 ~ 가혹조건시 조기 교환
// 디퍼런셜오일
// 매 20,000km / 2년
// 가혹조건,적재량이 많은 차량 교환
// 트랜스퍼오일
// 매 30,000km / 2년
// 통상조건
// 연료휠터	매 40,000km / 2년
// 가솔린, 커먼레일 디젤 필수 (수분발생 즉시 교환)
// 매 40,000km / 2년
// LPI (LPG 가스 사용 차량)
// 인젝터클리닝(연료라인)
// 매 40,000km / 2년
// 디젤차량 : 매연발생, 휘발유, 수분유입, 풀력부족시
// LPI(LPG)차량 : 시동불량시, 엔진부조시 즉시 시행
// 브레이크패드
// 매 30,000km
// 수시 점검
// 브레이크오일
// 매 3 ~ 40,000km / 2년
// 수분함량 및 오염시 비점 205℃이하시 교환
// 브레이크 디스크 연마
// 매 40,000km
// 제동시 브레이크페달 떨리거나 소음발생시(육안점검)
// 부동액
// 2년 & 40,000km
// 냉각수 오염시, 비중 저하시 즉시 교환
// 냉각라인 플러싱(세정)
// 매 40,000km / 2년 1회
// 냉각수 오염시, 녹 발생시 즉시
// 히터&에어컨 휠터	매 12,000km
// 상태 : 통상조건
// 매 10,000km
// 가혹 조건(비포장, 시내운전)
// 에어컨에바 / 히터클리닝(세정)
// 년 1 ~ 2회
// 에어컨 / 히터 악취 발생시
// 에어컨 냉매점검	매 20,000km
// 매 1년마다 점검 보충
// 매 40,000km
// 매 3년 가스 및 냉동유 교환
// 파워스티어링 오일
// 매 40,000km / 2년
// 오염 또는 조항력 증가시 교환
// 휠얼라이먼트
// 매 20,000km
// 타이어 편마모, 핸들 쏠림시 수시
// 밧데리
// 3년 & 5만 km
// 초기 시동 성능이 떨어질 때 (수시점검, 교환)
// 하체 언더코팅
// 신차 출고시 권장
// 부식방지 및 소음감소
}
