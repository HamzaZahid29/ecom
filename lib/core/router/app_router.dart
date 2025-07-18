import 'package:ecom/core/router/app_static_routes.dart';
import 'package:ecom/features/details/pages/product_detail_page.dart';
import 'package:ecom/features/favourites/pages/favourites_page.dart';
import 'package:ecom/features/listings/pages/listings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/pages/login_screen.dart';
import '../../features/device-info/pages/device_info_screen.dart';
import '../../features/profile/pages/profile_screen.dart';
import '../services/shared_prefrences_service.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GoRouter appRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: (BuildContext context, GoRouterState state) async {
    final isAuthenticated = await SharedPrefsService.isAuthenticated();
    final protectedRoutes = [AppStaticRoutes.profileScreen];
    final currentPath = state.uri.path;

    if (!isAuthenticated && protectedRoutes.contains(currentPath)) {
      return AppStaticRoutes.loginScreen;
    }

    return null;
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
    GoRoute(
      path: AppStaticRoutes.deviceInfo,
      name: AppStaticRoutes.deviceInfo,
      pageBuilder: (context, state) => MaterialPage(child: DeviceInfoScreen()),
    ),
    GoRoute(
      path: AppStaticRoutes.favouritesScreen,
      name: AppStaticRoutes.favouritesScreen,
      pageBuilder: (context, state) => MaterialPage(child: FavouritesPage()),
    ),
    GoRoute(
      path: '${AppStaticRoutes.productDetail}/:productId',
      name: AppStaticRoutes.productDetail,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return MaterialPage(child: ProductDetailPage(productId: productId));
      },
    ),
  ],
);
