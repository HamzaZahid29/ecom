import 'package:flutter/foundation.dart';

class ApiBaseProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  ApiBaseProvider() {
    init();
  }

  @protected
  void init() {}
}
