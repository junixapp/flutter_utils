import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fuck_utils/util/http/http_formatter.dart';
import 'package:fuck_utils/util/http/token_interceptor.dart';
import 'package:fuck_utils/util/log_util.dart';
import 'package:fuck_utils/util/object_util.dart';

extension ResponseExtension on Response? {
  bool get isSuccessful =>
      this != null &&
      this!.statusCode != null &&
      this!.statusCode! >= 200 &&
      this!.statusCode! < 300;
}

/// dio的封装
class HttpUtil {
  static Dio? _dio;
  static String _codeField = "code";
  static String _dataField = "data";
  static String _msgField = "msg";
  static dynamic _successCode = 0;

  static Dio? get dio => _dio;

  static void init({
    int timeout = 15,
    String baseUrl = "",
    String codeField = "",
    String dataField = "",
    String msgField = "",
    String successCode = "",
    String tokenHeaderName = "token",
    Function? tokenCreator,
    Function(dynamic)? onHookResponse,
  }) {
    _dio ??= Dio();
    _dio!.options.sendTimeout = Duration(seconds: timeout);
    _dio!.options.connectTimeout = Duration(seconds: timeout);
    _dio!.options.receiveTimeout = Duration(seconds: timeout);
    _dio!.options.baseUrl = baseUrl;
    _dio!.interceptors.add(HttpFormatter());
    _dio!.interceptors.add(TokenInterceptor(tokenHeaderName, tokenCreator, onHookResponse: onHookResponse));
    _codeField = codeField;
    _dataField = dataField;
    _msgField = msgField;
    _successCode = successCode;
  }

  static void addHeader(Map<String, dynamic> header) {
    _dio?.options.headers.addAll(header);
  }

  static void addInterceptor(InterceptorsWrapper interceptor) {
    _dio?.interceptors.insert(0, interceptor);
  }

  //业务是否成功
  static bool isSuccess(Map<String, dynamic>? map) =>
      map == null ? false : map[_codeField] == _successCode;

  static String? getMsg(Map<String, dynamic>? res) {
    return res == null ? null : res[_msgField];
  }

  static dynamic getData(Map<String, dynamic>? res) {
    return res == null ? null : res[_dataField];
  }

  static String? getCode(Map<String, dynamic>? res) {
    return res == null ? null : res[_codeField];
  }

  static dynamic _convertException(DioException e, String url, {Map? params}) {
    LogUtil.e("error: ${e.error.toString()}\nurl: ${_dio?.options.baseUrl}$url\nparams: ${params?.toString()} ");
    return null;
  }

  ///get请求
  static Future<Map?> get(String url, {Map<String, dynamic>? params}) async {
    try {
      var result = await _dio!.get(url, queryParameters: params);
      return result.isSuccessful ? (result.data ?? {}) : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    }
  }

  /// post请求，json编码
  static Future<Map<String, dynamic>?> postJson(
    String url,
    Map<String, dynamic> params,
  ) async {
    try {
      var result = await _dio!.post(url, data: params);
      var data = ObjectUtil.isEmpty(result.data) ? <String, dynamic>{} : result.data;
      return result.isSuccessful ? data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  /// post请求，form编码
  /// 如需上传文件，则直接把文件放入params参数。
  /// 单个文件：
  /// {'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')}
  /// 多个文件：
  /// { 'files': [
  ///       await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
  ///       await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
  ///   ]
  /// }
  static Future<Map?> postForm(
    String url,
    Map<String, dynamic> params, {
    Map<String, MultipartFile>? fileParams,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      if (fileParams != null && fileParams.isNotEmpty) {
        params.addAll(fileParams);
      }
      var result = (await _dio!.post(
        url,
        data: FormData.fromMap(params),
        onSendProgress: onSendProgress,
      ));
      return result.isSuccessful ? (result.data ?? {}) : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  ///直传文件
  static Future<Map?> postFile(String url, File file) async {
    try {
      var result = await _dio!.post(
        url,
        data: MultipartFile.fromFile(file.path),
      );
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    }
  }

  ///put请求
  static Future<Map?> put(String url, Map<String, dynamic> params) async {
    try {
      var result = (await _dio!.put(url, data: FormData.fromMap(params)));
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  ///直传文件
  static Future<Map?> putFile(String url, File file) async {
    try {
      var result = await _dio!.put(
        url,
        data: MultipartFile.fromFile(file.path),
      );
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    }
  }

  ///delete请求
  static Future<Map?> delete(String url, Map<String, dynamic> params) async {
    try {
      var result = await _dio!.delete(url, data: FormData.fromMap(params));
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  ///下载文件
  static Future<Response?> download(
    String url,
    String savePath,
    ProgressCallback? onReceiveProgress, {
    bool newClient = false,
  }) async {
    try {
      var client = newClient ? Dio() : _dio!;
      return await client.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      return _convertException(e, url);
    }
  }
}
