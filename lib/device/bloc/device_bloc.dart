import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:megaohm_api/megaohm_api.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'device_event.dart';

part 'device_state.dart';

part 'device_bloc.freezed.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc()
      : super(
          DeviceState(
            dateRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 1)),
              DateTime.now(),
            ),
          ),
        ) {
    on<DeviceEvent>((event, emit) {
      event.map(
        started: (_) async => _started(emit),
        discreteChanged: (value) async => _discreteChanged(value, emit),
        dateRangeChanged: (value) async => _dateRangeChanged(value, emit),
      );
    });
  }

  void _started(Emitter<DeviceState> emit) {}

  void _discreteChanged(_DiscreteChanged value, Emitter<DeviceState> emit) {
    emit(state.copyWith(discrete: value.discrete));
  }

  void _dateRangeChanged(_DateRangeChanged value, Emitter<DeviceState> emit) {
    emit(state.copyWith(dateRange: value.dateRange));
  }
}
