import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:megaohm_api/megaohm_api.dart';

part 'devices_event.dart';

part 'devices_state.dart';

part 'devices_bloc.freezed.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(const DevicesState()) {
    on<DevicesEvent>((event, emit) {
      event.map(
        started: (_) async => _started(emit),
        deviceAdded: (value) async => _deviceAdded(value, emit),
      );
    });
  }

  void _started(Emitter<DevicesState> emit) {}

  void _deviceAdded(_DeviceAdded value, Emitter<DevicesState> emit) {
    if (!state.devices.contains(value.device)) {
      emit(state.copyWith(devices: [...state.devices, value.device]));
    }
  }
}
