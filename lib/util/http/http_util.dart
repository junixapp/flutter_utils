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
  static const String _tokenHeader = "Authorization";
  static dynamic _successCode = 0;

  static Dio? get dio => _dio;

  static void init({
    int timeout = 15,
    String baseUrl = "",
    String? codeField,
    String? dataField,
    String? msgField,
    String? successCode,
    String? tokenHeaderName ,
    Function? tokenCreator,
    Map<String, dynamic>? header,
    Function(dynamic)? onHookResponse,
  }) {
    _dio ??= Dio();
    _dio!.options.sendTimeout = Duration(seconds: timeout);
    _dio!.options.connectTimeout = Duration(seconds: timeout);
    _dio!.options.receiveTimeout = Duration(seconds: timeout);
    _dio!.options.baseUrl = baseUrl;
    _dio!.interceptors.add(HttpFormatter());
    _dio!.interceptors.add(TokenInterceptor(tokenHeaderName ?? _tokenHeader, tokenCreator, onHookResponse: onHookResponse));
    if(ObjectUtil.isNotEmpty(codeField)) _codeField = codeField!;
    if(ObjectUtil.isNotEmpty(dataField)) _dataField = dataField!;
    if(ObjectUtil.isNotEmpty(msgField)) _msgField = msgField!;
    if(ObjectUtil.isNotEmpty(successCode)) _successCode = successCode!;
    if(header!=null) _dio?.options.headers.addAll(header);
  }

  ///will auto override the same header
  static void addHeader(Map<String, dynamic> header) {
    _dio?.options.headers.addAll(header);
  }

  static void addInterceptor(InterceptorsWrapper interceptor) {
    _dio?.interceptors.insert(0, interceptor);
  }

  //业务是否成功
  static bool isSuccess(Map? map) =>
      map == null ? false : map[_codeField] == _successCode;

  static String? getMsg(Map? res) {
    return res == null ? null : res[_msgField]?.toString();
  }

  static dynamic getData(Map? res) {
    return res == null ? null : res[_dataField];
  }

  static String? getCode(Map? res) {
    return res == null ? null : res[_codeField]?.toString();
  }

  static dynamic _convertException(Exception e, String url, {Map? params}) {
    LogUtil.e("error: ${e.toString()}\nurl: ${_dio?.options.baseUrl}$url\nparams: ${params?.toString()} ");
    if(e is SocketException){
      return {_codeField: -1, _msgField: e.message};
    }else{
      var de = e as DioException;
      String es = "";
      switch(de.type){
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
            es = "request timeout";
            break;
        case DioExceptionType.connectionError:
            es = "connection error";
            break;
        default:
            es = e.message??"";
            break;
      }
      return {_codeField: -1, _msgField: es};
    }
  }

  ///get请求
  static Future<Map<dynamic,dynamic>?> get(String url, {Map<String, dynamic>? params}) async {
    try {
      var result = await _dio!.get(url, queryParameters: params);
      return result.isSuccessful ? (result.data ?? {}) : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    } on SocketException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  /// post请求，json编码
  static Future<Map<dynamic,dynamic>?> post(
    String url, {Map<String, dynamic>? params}
  ) async {
    try {
      var result = await _dio!.post(url, data: params);
      var data = ObjectUtil.isEmpty(result.data) ? <String, dynamic>{} : result.data;
      return result.isSuccessful ? data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    } on SocketException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  /// post请求，form编码
  /// 如需上传文件，则传入MultipartFile类型，如：
  static Future<Map<dynamic,dynamic>?> postForm(
    String url,
    { Map<String, dynamic>? params,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      var result = (await _dio!.post(
        url,
        data: params!=null ? FormData.fromMap(params) : null,
        onSendProgress: onSendProgress,
      ));
      return result.isSuccessful ? (result.data ?? {}) : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    } on SocketException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  ///直传文件
  static Future<Map<dynamic,dynamic>?> postFile(String url, File file) async {
    try {
      var result = await _dio!.post(
        url,
        data: MultipartFile.fromFile(file.path),
      );
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    } on SocketException catch (e) {
      return _convertException(e, url);
    }
  }

  ///put请求
  static Future<Map<dynamic,dynamic>?> put(String url, Map<String, dynamic> params) async {
    try {
      var result = (await _dio!.put(url, data: FormData.fromMap(params)));
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    } on SocketException catch (e) {
      return _convertException(e, url, params: params);
    }
  }

  ///直传文件
  static Future<Map<dynamic,dynamic>?> putFile(String url, File file) async {
    try {
      var result = await _dio!.put(
        url,
        data: MultipartFile.fromFile(file.path),
      );
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url);
    } on SocketException catch (e) {
      return _convertException(e, url);
    }
  }

  ///delete请求
  static Future<Map<dynamic,dynamic>?> delete(String url, Map<String, dynamic> params) async {
    try {
      var result = await _dio!.delete(url, data: FormData.fromMap(params));
      return result.isSuccessful ? result.data : null;
    } on DioException catch (e) {
      return _convertException(e, url, params: params);
    } on SocketException catch (e) {
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
    } on SocketException catch (e) {
      return _convertException(e, url);
    }
  }
}
