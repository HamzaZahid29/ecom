import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/features/profile/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_text_styles.dart';

class BaseProfileInfoCard extends StatelessWidget {
  UserProfileModel data;

  BaseProfileInfoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(data?.image ?? ""),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.username ?? '', style: AppTextStyles.heading3),
                    Text(
                      'Full Name: ${data?.firstName ?? ''} ${data?.lastName ?? ''}',
                      style: AppTextStyles.caption,
                    ),
                    Text(
                      'Age : ${data?.age ?? 18}',
                      style: AppTextStyles.captionPrimary,
                    ),
                  ],
                ),
              ),
              Icon(HugeIcons.strokeRoundedArrowRight01),
            ],
          ),
        ),
      ],
    );
  }
}
