import 'package:flutter/material.dart';
import 'package:megaohm/consts.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    required this.id,
    required this.name,
    required this.onTap,
    super.key,
  });

  final String id;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(MegaohmConsts.defaultPadding),
          child: Column(
            children: [
              const Expanded(
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Icon(Icons.developer_board),
                ),
              ),
              Text(name),
              Text(id),
            ],
          ),
        ),
      ),
    );
  }
}
