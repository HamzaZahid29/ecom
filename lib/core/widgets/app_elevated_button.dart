import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

class AppElevatedButton extends StatelessWidget {
  VoidCallback? onTap;
  String lable;
  String? svgPath;

  AppElevatedButton({required this.onTap, required this.lable, this.svgPath});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Text(lable),
          svgPath == null
              ? Icon(
            Icons.arrow_circle_right_outlined,
            color: AppThemes.scaffoldBackgroundColor,
          )
              : SvgPicture.asset(svgPath ?? ''),
        ],
      ),
    );
  }
}
