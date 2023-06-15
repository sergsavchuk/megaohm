import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megaohm/consts.dart';

import 'package:megaohm/device/device.dart';
import 'package:megaohm/device/view/date_range_dialog.dart';
import 'package:megaohm/device/view/telemetry_chart.dart';
import 'package:megaohm_api/megaohm_api.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({required this.deviceId, super.key});

  final String deviceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceBloc(),
      child: DeviceView(deviceId: deviceId),
    );
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView({required this.deviceId, super.key});

  final String deviceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deviceId),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: MegaohmConsts.defaultPadding),
                const Text('Discrete:'),
                const SizedBox(width: MegaohmConsts.defaultPadding),
                BlocBuilder<DeviceBloc, DeviceState>(
                  builder: (context, state) {
                    return DropdownButton(
                      value: state.discrete,
                      items: Discrete.values
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          )
                          .toList(),
                      onChanged: (value) => context.read<DeviceBloc>().add(
                            DeviceEvent.discreteChanged(value!),
                          ),
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: MegaohmConsts.defaultPadding),
                const Text('Date range:'),
                TextButton(
                  onPressed: () async {
                    final bloc = context.read<DeviceBloc>();
                    final dateRange = await showDialog<PickerDateRange>(
                      context: context,
                      builder: (_) => DateRangeDialog(
                        initialSelectedRange: bloc.state.dateRange!,
                      ),
                    );
                    if (dateRange == null) return;

                    bloc.add(DeviceEvent.dateRangeChanged(dateRange));
                  },
                  child: BlocBuilder<DeviceBloc, DeviceState>(
                    builder: (context, state) {
                      return Text(
                        '${state.dateRange!.startDate!.toIsoString()}'
                        ' -> '
                        '${state.dateRange!.endDate!.toIsoString()}',
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<DeviceBloc, DeviceState>(
                  builder: (context, state) {
                    return FutureBuilder(
                      future: context.read<MegaohmApi>().getTmById(
                            id: deviceId,
                            startDate: state.dateRange!.startDate!,
                            endDate: state.dateRange!.endDate!,
                            discrete: state.discrete,
                          ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Expanded(
                                child: TelemetryChart(
                                  title: 'Temperature',
                                  data: snapshot.data!.data,
                                  dataExtractor: (sensor) => sensor?.t ?? 0,
                                ),
                              ),
                              Expanded(
                                child: TelemetryChart(
                                  title: 'Humidity',
                                  data: snapshot.data!.data,
                                  dataExtractor: (sensor) => sensor?.h ?? 0,
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          log('Telemetry request error', error: snapshot.error);
                          return const Text('Error loading telemetry data');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
