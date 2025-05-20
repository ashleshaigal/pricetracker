import 'package:dio/dio.dart';
import '../model/api_response.dart';

abstract class IGoldRateService {
  Future<ApiResponse> fetchGoldRates(String metalType, int days);
}

class GoldRateService implements IGoldRateService {
  final Dio _dio;

  GoldRateService(this._dio);

  @override
  Future<ApiResponse> fetchGoldRates(String metalType, int days) async {
    final response = await _dio.get(
      'https://agent-marketing-api.gfau.augmont.com/api/goldsilverrate',
      queryParameters: {'metalType': metalType, 'days': days},
    );
    return ApiResponse.fromJson(response.data);
  }
}
