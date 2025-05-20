import 'gold_rate_model.dart';

class ApiResponse {
  final int statusCode;
  final String message;
  final GoldRateModel result;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      result: GoldRateModel.fromJson(json['result']),
    );
  }
}