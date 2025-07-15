import 'package:ecom/core/constants/app_constants.dart';
import 'package:ecom/core/router/app_static_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class ListingsScreen extends StatelessWidget {
  const ListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppConstants.appName}'),
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(AppStaticRoutes.profileScreen);
          }, icon: Icon(HugeIcons.strokeRoundedUser),),
        ],
      ),
    );
  }
}
