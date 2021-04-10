import 'package:alpha_sample/models/internal/response_data.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/services/network_service.dart';

class BaseRepository {
  final service = locator<NetworkService>();

  Future<ResponseData> get(String path, {dynamic param}) async {
    await service.onReady;
    final response = await service.dio.get(path, queryParameters: param);
    return ResponseData.fromJson(response.data);
  }

  Future<dynamic> getList(String path, {dynamic param}) async {
    await service.onReady;
    final response = await service.dio.get(path, queryParameters: param);
    return response;
  }

  Future<ResponseData> post(String path, {dynamic data}) async {
    await service.onReady;
    final response = await service.dio.post(path, data: data);
    return ResponseData.fromJson(response.data);
  }

  Future<ResponseData> put(String path, {dynamic data}) async {
    await service.onReady;
    final response = await service.dio.put(path, data: data);
    return ResponseData.fromJson(response.data);
  }
}
