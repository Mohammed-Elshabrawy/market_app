import 'package:dio/dio.dart';
import 'package:market_app/shared/network/remote/supabase_key.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      headers: {'apikey': anonKey},
    ),
  );
  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }
}
