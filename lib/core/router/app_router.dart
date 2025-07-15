import 'dart:developer';
import 'package:ecom/core/router/app_static_routes.dart';
import 'package:ecom/features/listings/pages/listings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/pages/login_screen.dart';
import '../../features/profile/pages/profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GoRouter appRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: (BuildContext context, GoRouterState state) async {
    // final isAuthenticated = await SharedPrefsService.isAuthenticated();
    final isAuthenticated = false;
    final protectedRoutes = [
      // AppStaticRoutePaths.profilePage,
      // AppStaticRoutePaths.messagesPage,
      // AppStaticRoutePaths.messageDetailPage,
      // AppStaticRoutePaths.theBookingsPage,
      // AppStaticRoutePaths.confirmAndPay,
      // AppStaticRoutePaths.favouritesPage
    ];
    final currentPath = state.uri.path;

    if (!isAuthenticated && protectedRoutes.contains(currentPath)) {
      return AppStaticRoutes.loginScreen;
    }

    return null; // no redirect
  },
  routes: [
    GoRoute(
      path: AppStaticRoutes.loginScreen,
      name: AppStaticRoutes.loginScreen,
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      path: AppStaticRoutes.profileScreen,
      name: AppStaticRoutes.profileScreen,
      pageBuilder: (context, state) => MaterialPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: AppStaticRoutes.listingsScreen,
      name: AppStaticRoutes.listingsScreen,
      pageBuilder: (context, state) => MaterialPage(child: ListingsScreen()),
    ),
  ],
);
