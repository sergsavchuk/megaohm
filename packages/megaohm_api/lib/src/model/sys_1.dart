import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:megaohm_api/src/model/sensor.dart';

part 'sys_1.freezed.dart';

part 'sys_1.g.dart';

@freezed
class Sys1 with _$Sys1 {
  factory Sys1({
    required List<Sensor> sensors,
  }) = _Sys1;

  factory Sys1.fromJson(Map<String, dynamic> json) => _$Sys1FromJson(json);
}
