import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/theme/app_text_styles.dart';
import 'package:ecom/features/profile/provider/profile_provider.dart';
import 'package:ecom/features/profile/widgets/base_profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Column(
            children: [
              Consumer<UserProfileProvider>(
                builder: (context, provider, child) {
                  final data = provider.userProfileModel;
                  return BaseProfileInfoCard(data: data!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
