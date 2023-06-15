import 'package:flutter/material.dart';
import 'package:megaohm/consts.dart';
import 'package:megaohm_api/megaohm_api.dart';

class AddDeviceDialog extends StatefulWidget {
  const AddDeviceDialog({super.key});

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(MegaohmConsts.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add device'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Device name',
              ),
            ),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Device id',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _addDevice,
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addDevice() {
    // TODO(sergsavchuk): add validation

    final device = Device(
      id: _idController.text,
      name: _nameController.text,
    );
    Navigator.of(context).pop(device);
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
