import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
class ProfileScreenTile extends StatelessWidget {
  IconData leadingIcon;
  String title;


  ProfileScreenTile(this.leadingIcon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
        child: Row(
          spacing: 10,
          children: [
            Icon(leadingIcon),
            Expanded(child: Text(title)),
            Icon(HugeIcons.strokeRoundedArrowRight01)
          ],
        ),
      ),
    );
  }
}
