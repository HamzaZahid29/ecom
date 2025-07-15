import 'package:ecom/core/services/shared_prefrences_service.dart';
import 'package:ecom/features/profile/models/profile_model.dart';

import '../../../core/network/api_result.dart';
import '../../../core/providers/app_base_provider.dart';
import '../repository/profile_repostiory.dart';

class UserProfileProvider extends ApiBaseProvider {
  final ProfileRepository _profileRepository = ProfileRepository.instance;

  UserProfileModel? _userProfileModel;
  String? _errorMessage;
  DateTime? _lastFetchTime;
  bool _isInitialized = false;

  static const Duration _cacheTimeout = Duration(minutes: 5);

  UserProfileModel? get userProfileModel => _userProfileModel;
  String? get errorMessage => _errorMessage;
  bool get hasProfile => _userProfileModel != null;
  bool get isCacheValid => _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheTimeout;

  Future<UserProfileModel?> getProfileLazy({bool forceRefresh = false}) async {
    if (!forceRefresh && isCacheValid && _userProfileModel != null) {
      print('Returning cached profile data');
      return _userProfileModel;
    }

    if (isLoading) {
      return _userProfileModel;
    }

    await getUserProfile();
    return _userProfileModel;
  }

  Future<void> initializeIfAuthenticated() async {
    if (_isInitialized) return;

    _isInitialized = true;
    final isAuthenticated = await SharedPrefsService.isAuthenticated();

    if (isAuthenticated) {
      print('User is authenticated, initializing profile...');
      await getUserProfile();
    }
  }

  Future<void> getUserProfile() async {
    setLoading(true);
    _errorMessage = null;

    try {
      print('Fetching user profile from API...');
      final result = await _profileRepository.getProfile();

      if (result is Success) {
        _userProfileModel = UserProfileModel.fromJson(result.data);
        _lastFetchTime = DateTime.now();
        _errorMessage = null;
        print('Profile fetched successfully');
        notifyListeners();
      } else if (result is Failure) {
        _errorMessage = result.error;
        print('Profile fetch failed: ${result.error}');
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Unexpected Error: $e';
      print('Profile fetch error: $e');
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshProfile() async {
    print('Force refreshing profile...');
    await getUserProfile();
  }

  void updateProfileLocally(UserProfileModel updatedProfile) {
    _userProfileModel = updatedProfile;
    _lastFetchTime = DateTime.now(); // Reset cache timer
    notifyListeners();
  }

  void clearCache() {
    _userProfileModel = null;
    _lastFetchTime = null;
    _errorMessage = null;
    notifyListeners();
  }
  bool get isCacheExpired => !isCacheValid;

  int get cacheAgeInMinutes {
    if (_lastFetchTime == null) return 0;
    return DateTime.now().difference(_lastFetchTime!).inMinutes;
  }

  Future<void> logout() async {
    await SharedPrefsService.clearTokens();
    _userProfileModel = null;
    _lastFetchTime = null;
    _errorMessage = null;
    _isInitialized = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _userProfileModel = null;
    _lastFetchTime = null;
    _errorMessage = null;
    super.dispose();
  }
}