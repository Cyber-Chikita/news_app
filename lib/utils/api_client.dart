import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _host = "bing-news-search1.p.rapidapi.com";
const _apiKey = "";
const _sdk = "true";

const _sdkLabel = "x-bingapis-sdk";
const _hostLabel = "x-rapidapi-host";
const _keyLabel = "x-rapidapi-key";

class ApiClient {
  static const String url = "https://bing-news-search1.p.rapidapi.com";

  static Map<String, dynamic> headers = {
    _sdkLabel: _sdk,
    _hostLabel: _host,
    _keyLabel: _apiKey,
  };

  static final BaseOptions _options = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 5000,
    sendTimeout: 5000,
    receiveTimeout: 5000,
    headers: headers,
  );

  static final dio = _createDio();

  static Dio _createDio() {
    Dio dio = Dio(_options);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120,
    ));
    return dio;
  }

  static String handleNetworkError(dynamic error) {
    String errorMsg = "Неизвестная ошибка.";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorMsg = "Запрос на сервер отклонен. Повторите попытку позже.";
              break;
            case DioErrorType.connectTimeout:
              errorMsg = "Время ожидания ответа от сервера истекло.";
              break;
            case DioErrorType.other:
              errorMsg =
                  "Проверьте подключение к интернету и повторите попытку.";
              break;
            case DioErrorType.receiveTimeout:
              errorMsg = "Время получения данных истекло.";
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  errorMsg = "Несанкционированный запрос на сервер. [400]";
                  break;
                case 401:
                  errorMsg = "Несанкционированный запрос на сервер. [401]";
                  break;
                case 403:
                  errorMsg = "Несанкционированный запрос на сервер. [403]";
                  break;
                case 404:
                  errorMsg = "Сервер не найден. [404]";
                  break;
                case 409:
                  errorMsg =
                      "Возник конфликт с сервером. Повторите попытку позже. [409]";
                  break;
                case 408:
                  errorMsg = "Время ожидания ответа от сервера истекло. [408]";
                  break;
                case 500:
                  errorMsg =
                      "Критическая ошибка на сервере. Повторите попытку позже. [500]";
                  break;
                case 503:
                  errorMsg = "Сервер не доступен. [503]";
                  break;
                default:
                  int statusCode = error.response?.statusCode ?? -1;
                  errorMsg =
                      "Неизвестная ошибка при получении данных. [$statusCode]";
              }
              break;
            case DioErrorType.sendTimeout:
              errorMsg = "Время получения данных истекло.";
              break;
          }
        } else if (error is SocketException) {
          errorMsg = "Проверьте подключение к интернету и повторите попытку.";
        } else {
          errorMsg = "Неизвестная ошибка при получении данных.";
        }
        return errorMsg;
      } on FormatException {
        return "Неизвестная ошибка при получении данных.";
      } catch (_) {
        return "Неизвестная ошибка при получении данных.";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "Получен некорректный тип данных.";
      } else {
        return "Неизвестная ошибка при получении данных.";
      }
    }
  }
}
