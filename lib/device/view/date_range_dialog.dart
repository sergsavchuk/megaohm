import 'package:flutter/material.dart';
import 'package:megaohm/consts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeDialog extends StatefulWidget {
  const DateRangeDialog({required this.initialSelectedRange, super.key});

  final PickerDateRange initialSelectedRange;

  @override
  State<DateRangeDialog> createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  final _materialStateController = MaterialStatesController();

  PickerDateRange? _range;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(MegaohmConsts.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              initialSelectedRange: widget.initialSelectedRange,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: _onSelectionChanged,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                statesController: _materialStateController,
                onPressed: _confirm,
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final range = args.value as PickerDateRange?;
    if (range == null || range.startDate == null || range.endDate == null) {
      _materialStateController.update(MaterialState.disabled, true);
      return;
    }

    _range = range;
    _materialStateController.update(MaterialState.disabled, false);
  }

  void _confirm() {
    if (_materialStateController.value.contains(MaterialState.disabled)) {
      return;
    }

    if (_range == null) {
      Navigator.of(context).pop(widget.initialSelectedRange);
      return;
    }

    Navigator.of(context).pop(_range);
  }
}
