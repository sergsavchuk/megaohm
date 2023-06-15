part of 'device_bloc.dart';

@freezed
class DeviceEvent with _$DeviceEvent {
  const factory DeviceEvent.started() = _Started;

  const factory DeviceEvent.discreteChanged(Discrete discrete) =
      _DiscreteChanged;

  const factory DeviceEvent.dateRangeChanged(PickerDateRange dateRange) =
      _DateRangeChanged;
}
