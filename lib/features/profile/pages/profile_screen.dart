import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/theme/app_text_styles.dart';
import 'package:ecom/core/widgets/app_elevated_button.dart';
import 'package:ecom/features/profile/provider/profile_provider.dart';
import 'package:ecom/features/profile/widgets/base_profile_info_card.dart';
import 'package:ecom/features/profile/widgets/profile_screen_tile.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0,),
          child: Column(
            children: [
              Consumer<UserProfileProvider>(
                builder: (context, provider, child) {
                  final data = provider.userProfileModel;
                  return BaseProfileInfoCard(data: data!);
                },
              ),
              SizedBox(height: 20,),
              ProfileScreenTile(HugeIcons.strokeRoundedUser, 'Profile Details'),
              ProfileScreenTile(HugeIcons.strokeRoundedSmartPhone02, 'View Device Info'),
              ProfileScreenTile(HugeIcons.strokeRoundedShoppingCart02, 'Cart'),
              SizedBox(height: 20,),
              AppElevatedButton(onTap: (){}, lable: 'Logout')
            ],
          ),
        ),
      ),
    );
  }
}
