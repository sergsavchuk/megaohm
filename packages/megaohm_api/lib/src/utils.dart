import 'package:json_annotation/json_annotation.dart';

class UnixTsDateTimeConverter implements JsonConverter<DateTime, String> {
  const UnixTsDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.fromMillisecondsSinceEpoch(
      (double.parse(json) * 1000).toInt(),
    );
  }

  @override
  String toJson(DateTime object) {
    return (object.millisecondsSinceEpoch / 1000.0).toString();
  }
}

extension IsoDateTimeExtension on DateTime {
  String toIsoString() {
    return toIso8601String().split('T').first;
  }
}
