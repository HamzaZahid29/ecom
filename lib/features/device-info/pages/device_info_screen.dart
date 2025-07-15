import 'package:ecom/core/theme/app_text_styles.dart';
import 'package:ecom/features/device-info/providers/device_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Info')),
      body: ChangeNotifierProvider(
        create: (_) => DeviceInfoProvider(),
        child: Consumer<DeviceInfoProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                      itemCount: provider.deviceInfo?.toMap().length ?? 0,
                      itemBuilder: (context, index) {
                        final entries = provider.deviceInfo!
                            .toMap()
                            .entries
                            .toList();
                        final key = entries[index].key;
                        final value = entries[index].value.toString();
                        return DeviceInfoTile(key, value);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class DeviceInfoTile extends StatelessWidget {
  String title;
  String value;

  DeviceInfoTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.caption),
            Text(value, style: AppTextStyles.captionDark),
          ],
        ),
      ),
    );
  }
}
