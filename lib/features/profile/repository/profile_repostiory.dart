import '../../../core/network/api_clients/app_api_client.dart';
import '../../../core/network/api_result.dart';

class ProfileRepository {
  final AppApiClient _apiClient = AppApiClient();

  ProfileRepository._privateConstructor();

  static final ProfileRepository instance =
      ProfileRepository._privateConstructor();

  Future<ApiResult> getProfile() async {
    final result = await _apiClient.get('auth/me');

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.error);
    }

    return Failure("Unknown error occurred.");
  }
}
