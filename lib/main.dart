import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/profile/provider/profile_provider.dart';
import 'globals.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final profileProvider = UserProfileProvider();

  await profileProvider.initializeIfAuthenticated();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider.value(value: profileProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      title: AppConstants.appName,
      routerConfig: appRoutes,
    );
  }
}
