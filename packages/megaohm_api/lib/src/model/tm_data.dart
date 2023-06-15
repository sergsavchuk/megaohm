import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:megaohm_api/src/model/sys_1.dart';
import 'package:megaohm_api/src/utils.dart';

part 'tm_data.freezed.dart';

part 'tm_data.g.dart';

@freezed
class TmData with _$TmData {
  factory TmData({
    @UnixTsDateTimeConverter()
    required DateTime ts,
    Sys1? air,
  }) = _TmData;

  factory TmData.fromJson(Map<String, dynamic> json) => _$TmDataFromJson(json);
}
