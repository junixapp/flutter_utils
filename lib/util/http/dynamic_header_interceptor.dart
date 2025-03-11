import 'package:dio/dio.dart';
import 'package:fuck_utils/util/object_util.dart';

///
/// 用于动态添加header的拦截器
class DynamicHeaderInterceptor implements InterceptorsWrapper {
  Map<String,dynamic> Function() headerCreator;
  Function(dynamic)? onHookResponse;
  DynamicHeaderInterceptor(this.headerCreator, {this.onHookResponse});

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var headers = headerCreator!();
    options.headers.addAll(headers);
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    var ct = response.headers.value("content-type");
    if(ct!=null && ( ct.contains("application/json") || ct.contains("text/html"))){
      var data = response.data;
      if(onHookResponse!=null) onHookResponse!(data);
    }
    return handler.next(response);
  }
}
