import 'package:megaohm_api/src/model/model.dart';

class TmDataset {
  TmDataset(this.data);

  factory TmDataset.fromJson(List<dynamic> jsonArray) {
    return TmDataset(
      jsonArray.map((e) => TmData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  final List<TmData> data;
}
