import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:megaohm/consts.dart';

import 'package:megaohm/devices/devices.dart';
import 'package:megaohm/devices/view/add_device_dialog.dart';
import 'package:megaohm/devices/view/device_card.dart';
import 'package:megaohm_api/megaohm_api.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DevicesBloc(),
      child: const DevicesView(),
    );
  }
}

class DevicesView extends StatelessWidget {
  const DevicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(MegaohmConsts.defaultPadding),
          child: BlocBuilder<DevicesBloc, DevicesState>(
            builder: (context, state) => GridView.count(
              crossAxisCount: 2,
              children: state.devices
                  .map(
                    (device) => DeviceCard(
                      id: device.id,
                      name: device.name,
                      onTap: () => context.push('/device/${device.id}'),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showDialog<Device>(
            context: context,
            builder: (_) => const AddDeviceDialog(),
          ).then((device) {
            if (device != null) {
              context.read<DevicesBloc>().add(DevicesEvent.deviceAdded(device));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
