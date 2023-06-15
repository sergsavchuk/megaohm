part of 'devices_bloc.dart';

@freezed
class DevicesState with _$DevicesState {
  const factory DevicesState({
    @Default([Device(id: '12ABCDEF', name: 'Test Device')])
    List<Device> devices,
  }) = _Initial;
}
