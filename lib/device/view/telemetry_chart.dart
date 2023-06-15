import 'package:flutter/material.dart';
import 'package:megaohm_api/megaohm_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TelemetryChart extends StatelessWidget {
  const TelemetryChart({
    required this.title,
    required this.data,
    required this.dataExtractor,
    super.key,
  });

  final String title;
  final List<TmData> data;
  final num Function(Sensor? data) dataExtractor;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: title),
      legend: Legend(isVisible: true),
      primaryXAxis: DateTimeAxis(),
      series: <ChartSeries<TmData, DateTime>>[
        LineSeries<TmData, DateTime>(
          name: data[0].air?.sensors[0].sid ?? 's1',
          dataSource: data,
          xValueMapper: (telemetry, _) => telemetry.ts,
          yValueMapper: (telemetry, _) =>
              dataExtractor(telemetry.air?.sensors[0]),
        ),
        LineSeries<TmData, DateTime>(
          name: data[0].air?.sensors[1].sid ?? 's2',
          dataSource: data,
          xValueMapper: (telemetry, _) => telemetry.ts,
          yValueMapper: (telemetry, _) =>
              dataExtractor(telemetry.air?.sensors[1]),
        ),
      ],
    );
  }
}
