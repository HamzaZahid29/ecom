import 'package:ecom/core/router/app_static_routes.dart';
import 'package:ecom/core/services/app_snackbar_service.dart';
import 'package:ecom/features/auth/models/user_login_model.dart';
import 'package:ecom/features/profile/provider/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_result.dart';
import '../../../core/providers/app_base_provider.dart';
import '../../../core/services/app_log_service.dart';
import '../../../core/services/shared_prefrences_service.dart';
import '../respository/auth_repository.dart';

class AuthProvider extends ApiBaseProvider {
  final AuthRepository _authRepository = AuthRepository.instance;

  bool _isObsecured = true;

  bool get isObsecured => _isObsecured;

  void toggleObsecured() {
    _isObsecured = !_isObsecured;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    setLoading(true);
    try {
      final result = await _authRepository.login(email, password);

      if (result is Success) {
        final loginSuccessModel = UserLoginModel.fromJson(result.data);
        notifyListeners();
        final accessToken = loginSuccessModel?.accessToken ?? '';
        final refreshToken = loginSuccessModel?.refreshToken ?? '';
        await SharedPrefsService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        final userProfileProvider = context.read<UserProfileProvider>();
        await userProfileProvider.getUserProfile();
        context.goNamed(AppStaticRoutes.listingsScreen);
      } else if (result is Failure) {
        AppSnackbarService.showSnackbar(result.error);
      }
    } catch (e) {
      LogService.debug(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
