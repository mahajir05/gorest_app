import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/core/interfaces/print_utils.dart';

class ApiService {
  final Dio dio;
  CancelToken cancelToken = CancelToken();

  ApiService({required this.dio}) {
    dio.options.headers.addAll({Headers.acceptHeader: 'application/json'});
    dio.options.headers.addAll({Headers.contentTypeHeader: 'application/json'});
  }

  ApiService baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    return this;
  }

  ApiService tokenBearer(String? token) {
    dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            //Get old token//
            debugPrint("[Init Refresh token]");
            debugPrint("Old token $token");
            try {
              final response = await dio.post(
                'endPointRefreshToken',
                queryParameters: {
                  'Token': token,
                },
              );

              //Get Refresh Token From API
              final newToken = response.data['data']['Token'];
              debugPrint("[Resolving Refresh token]");
              debugPrint("Old token $token");
              debugPrint("New token $newToken");

              //Request previous that failed 401
              final cloneReq = await dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              return handler.resolve(cloneReq);
            } catch (e) {
              debugPrint("Error: Failed Get new token.");
            }
          }
          return handler.next(e);
        },
      ),
    );
    return this;
  }

  ApiService addOtherHeader({required Map<String, String> headers}) {
    dio.options.headers.addAll(headers);
    return this;
  }

  Future<Response> get({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = true,
    bool isUseCancelToken = true,
  }) async {
    printYellow('===> CALL API <===');
    debugPrint('URL : ${dio.options.baseUrl}$apiPath');
    debugPrint('Method : GET');
    debugPrint("Header : ${dio.options.headers}");
    debugPrint("Request : $request");
    try {
      Response response;
      response = await dio.get(
        apiPath,
        queryParameters: request,
        cancelToken: isUseCancelToken ? cancelToken : null,
      );
      printGreen('Success [METHOD GET] $apiPath');
      printGreen('Success Response : ${response.data}');
      debugPrint('---');
      return response;
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        printRed('Error: [METHOD GET] $apiPath: $e');
        printRed('Error: $apiPath: ${e.response?.data}');
        debugPrint('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "code": 0011,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "code": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        printRed('Error: [METHOD GET] $apiPath: $e');
        printRed('Error: $apiPath: ${response.data}');
        debugPrint('---');
        return response;
      }
    }
  }

  Future<Response> post({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
  }) async {
    printYellow('===> CALL API <===');
    debugPrint('URL : ${dio.options.baseUrl}$apiPath');
    debugPrint('Method : POST');
    debugPrint("Header : ${dio.options.headers}");
    debugPrint("Request : $request");
    try {
      Response response;
      response = await dio.post(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      printGreen('Success [METHOD POST] $apiPath');
      printGreen('Success Response : ${response.data}');
      debugPrint('---');
      return response;
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        printRed('Error : [METHOD POST] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "code": 0011,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "code": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        printRed('Error : [METHOD POST] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return response;
      }
    }
  }

  Future<Response> postList({
    required String apiPath,
    List<Map<String, dynamic>>? request,
  }) async {
    printYellow('===> CALL API <===');
    debugPrint('URL : ${dio.options.baseUrl}$apiPath');
    debugPrint('Method : POST');
    debugPrint("Header : ${dio.options.headers}");
    debugPrint("Request : $request");
    try {
      Response response;
      response = await dio.post(
        apiPath,
        data: request,
        cancelToken: cancelToken,
      );
      printGreen('Success [METHOD POST] $apiPath');
      printGreen('Success Response : ${response.data}');
      debugPrint('---');
      return response;
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        printRed('Error : [METHOD POST] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "code": 0011,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "code": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        printRed('Error : [METHOD POST] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return response;
      }
    }
  }

  Future<Response> put({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = true,
  }) async {
    printYellow('===> CALL API <===');
    dio.options.headers.addAll({
      'Content-Type': 'application/x-www-form-urlencoded',
    });
    debugPrint('URL : ${dio.options.baseUrl}$apiPath');
    debugPrint('Method : PUT');
    debugPrint("Header : ${dio.options.headers}");
    debugPrint("Request : $request");
    try {
      Response response;
      response = await dio.put(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      printGreen('Success [METHOD PUT] $apiPath');
      printGreen('Success Response : ${response.data}');
      debugPrint('---');
      return response;
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        printRed('Error: [METHOD PUT] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "code": 0011,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "code": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        printRed('Error: [METHOD PUT] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return response;
      }
    }
  }

  Future<Response> delete({
    required String apiPath,
    Map<String, dynamic>? request,
    bool useFormData = false,
  }) async {
    printYellow('===> CALL API <===');
    debugPrint('URL : ${dio.options.baseUrl}$apiPath');
    debugPrint('Method : DELETE');
    debugPrint("Header : ${dio.options.headers}");
    debugPrint("Request : $request");
    try {
      Response response;
      response = await dio.delete(
        apiPath,
        data: useFormData ? FormData.fromMap(request!) : request,
        cancelToken: cancelToken,
      );
      printGreen('Success [METHOD DELETE] $apiPath');
      printGreen('Success Response : ${response.data}');
      debugPrint('---');
      return response;
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        (e.response?.data as Map).addAll(<String, dynamic>{
          "status": "error",
        });
        printRed('Error: [METHOD DELETE] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return e.response!;
      } else {
        Response response = Response(
          data: {
            "code": 0011,
            "message": "error",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        if (cancelToken.isCancelled) {
          response = Response(
            data: {
              "code": null,
              "message": "request cancelled",
            },
            requestOptions: e.requestOptions,
            statusCode: e.response?.statusCode,
          );
        }
        printRed('Error: [METHOD DELETE] $apiPath: $e');
        printRed('Error : $apiPath: ${e.response?.data}');
        debugPrint('---');
        return response;
      }
    }
  }
}
