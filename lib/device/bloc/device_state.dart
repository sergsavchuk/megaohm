part of 'device_bloc.dart';

@freezed
class DeviceState with _$DeviceState {
  factory DeviceState({
    @Default(Discrete.hourly) Discrete discrete,
    PickerDateRange? dateRange,
  }) = _Initial;
}
