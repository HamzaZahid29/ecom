class ApiErrorModel {
  final String status;
  final int code;
  final String message;

  ApiErrorModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
    );
  }
}

