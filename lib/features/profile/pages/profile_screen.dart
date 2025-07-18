import 'package:ecom/core/router/app_static_routes.dart';
import 'package:ecom/core/widgets/app_elevated_button.dart';
import 'package:ecom/features/profile/provider/profile_provider.dart';
import 'package:ecom/features/profile/widgets/base_profile_info_card.dart';
import 'package:ecom/features/profile/widgets/profile_screen_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          padding: const EdgeInsets.all(18.0),
          child: Consumer<UserProfileProvider>(
            builder: (context, provider, child) {
              final data = provider.userProfileModel;

              return Column(
                children: [
                  (data == null)
                      ? Center(child: Text('Login First'))
                      : BaseProfileInfoCard(data: data!),
                  SizedBox(height: 20),
                  ProfileScreenTile(
                    HugeIcons.strokeRoundedSmartPhone02,
                    'View Device Info',
                    () {
                      context.pushNamed(AppStaticRoutes.deviceInfo);
                    },
                  ),
                  ProfileScreenTile(
                    HugeIcons.strokeRoundedFavourite,
                    'Favourites',
                    () {
                      context.pushNamed(AppStaticRoutes.favouritesScreen);
                    },
                  ),
                  SizedBox(height: 20),
                  AppElevatedButton(
                    onTap: () async {
                      await provider.logout().then((_) {
                        context.pop();
                      });
                    },
                    lable: 'Logout',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
