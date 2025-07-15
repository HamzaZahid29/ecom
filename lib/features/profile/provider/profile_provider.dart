import 'package:ecom/core/services/app_snackbar_service.dart';
import 'package:ecom/features/profile/models/profile_model.dart';

import '../../../core/network/api_result.dart';
import '../../../core/providers/app_base_provider.dart';
import '../repository/profile_repostiory.dart';

class UserProfileProvider extends ApiBaseProvider {
  final ProfileRepository _profileRepository = ProfileRepository.instance;

  UserProfileModel? userProfileModel;

  ProfileProvider() {
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    setLoading(true);
    try {
      final result = await _profileRepository.getProfile();
      if (result is Success) {
        var data = UserProfileModel.fromJson(result.data);
        userProfileModel = data;
        notifyListeners();
      } else if (result is Failure) {
        AppSnackbarService.showSnackbar(result.error);
      }
    } catch (e) {
      print(e.toString());
      AppSnackbarService.showSnackbar('Unexpected Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    userProfileModel = null;
    notifyListeners();
  }
}