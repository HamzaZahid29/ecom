import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

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
