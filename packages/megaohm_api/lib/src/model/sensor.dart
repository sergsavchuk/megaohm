import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor.freezed.dart';

part 'sensor.g.dart';

@freezed
class Sensor with _$Sensor {
  const factory Sensor({
    required String sid,
    required double t,
    required double h,
  }) = _Sensor;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
}
