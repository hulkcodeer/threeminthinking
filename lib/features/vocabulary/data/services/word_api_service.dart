import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'word_api_service.g.dart';

@RestApi()
abstract class WordApiService {
  factory WordApiService(Dio dio) = _WordApiService;

  @POST('/chat/completions')
  @Headers({'Content-Type': 'application/json'})
  Future<Map<String, dynamic>> searchWord(@Body() Map<String, dynamic> body);
}
