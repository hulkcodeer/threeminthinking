import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/features/vocabulary/data/services/word_api_service.dart';
import 'package:threeminthinking/flavors.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  var dio = Dio(BaseOptions(baseUrl: F.baseUrl, contentType: Headers.jsonContentType
      //  receiveTimeout: const Duration(seconds: 30)
      ));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    var secureStorage = const FlutterSecureStorage();

    var token = await secureStorage.read(key: 'token');
    var authType = await secureStorage.read(key: 'authType');

    options.headers['Authorization'] = 'Bearer ${token}';
    options.headers['AuthType'] = authType;
    return handler.next(options);
  }));

  dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  return dio;
}

@riverpod
Dio chatGPTDio(Ref ref) {
  var dio = Dio(BaseOptions(
    baseUrl: 'https://api.openai.com/v1',
    contentType: Headers.jsonContentType,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.headers['Authorization'] = 'Bearer ${dotenv.env['OPENAI_API_KEY']}';
      return handler.next(options);
    },
  ));

  dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  return dio;
}

@riverpod
WordApiService wordApiService(Ref ref) {
  return WordApiService(ref.watch(chatGPTDioProvider));
}
