import 'package:flutter/foundation.dart';

class ApiBaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;

  bool get isLoading => _isLoading;

  bool get isError => _isError;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(bool error) {
    _isError = error;
    notifyListeners();
  }

  ApiBaseProvider() {
    init();
  }

  @protected
  void init() {}
}
